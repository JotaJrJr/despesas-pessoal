import 'package:despesas/common/database/app_db.dart';
import 'package:despesas/common/database/services/service_despesa_impl.dart';
import 'package:despesas/common/feature/cadastrar_despesa/view/cadastrar_despesa_page.dart';
import 'package:despesas/common/feature/filtro/view/filtro_page.dart';
import 'package:despesas/common/feature/lista_despesas/viewmodel/lista_despesas_view_model.dart.dart';
import 'package:despesas/common/feature/lista_despesas/widgets/donut_chat_widget.dart';
import 'package:despesas/common/models/despesa_model.dart';
import 'package:despesas/common/widgets/delete_despesa_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../utils/safe_handler.dart';

class ListaDespesasPage extends StatefulWidget {
  final int perfil;

  const ListaDespesasPage({super.key, required this.perfil});

  @override
  State<ListaDespesasPage> createState() => _ListaDespesasPageState();
}

class _ListaDespesasPageState extends State<ListaDespesasPage> with SingleTickerProviderStateMixin {
  late ListaDespesasViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = ListaDespesasViewModel(
      perfil: widget.perfil,
      serviceDespesaImpl: ServiceDespesaImpl(
        dao: Provider.of<AppDb>(context, listen: false).despesaDao,
      ),
    );

    _viewModel.fillListaDespesas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _navigateToPage(const FiltroPage()),
            icon: const Icon(Icons.filter_list),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToPage(CadastrarDespesaPage(
          perfil: widget.perfil,
        )).then((value) => _viewModel.fillListaDespesas()),
        child: const Icon(Icons.add),
      ),
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (_, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 14.0, left: 14.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                ),
              ),
              Center(
                child: DonutChartWidget(
                  despesas: _viewModel.listaDespesas,
                  valorTotal: _viewModel.valorTotal.toString(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // itemCount: _viewModel.listaDespesas.length,
                  itemCount: _viewModel.groupedDespesas.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String date = _viewModel.groupedDespesas.keys.elementAt(index);

                    List<DespesaModel> despesasForDate = _viewModel.groupedDespesas[date]!;

                    DespesaModel despesa = _viewModel.listaDespesas[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 5.0, bottom: 5.0),
                          child: Text(
                            date,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: despesasForDate.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    border: Border.all(
                                      color: Colors.red,
                                    )),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(SafeHandler.value(despesa.descricao)),
                                        Text(SafeHandler.value(despesa.descricaoCategoria)),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Text(SafeHandler.value(formatCurrency(despesa.valor!))),
                                        despesa.data != null ? Text(SafeHandler.value(formatTimestamp(despesa.data!))) : Container(),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () => showDeleteAlertDialog(despesa.id!),
                                      icon: const Icon(Icons.delete),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          );
        },
      ),
    );
  }

  String formatCurrency(double value) {
    NumberFormat currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return currencyFormat.format(value);
  }

  String formatTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }

  showDeleteAlertDialog(String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return DeleteDespesaDialogWidget(
            onPressed: () {
              _viewModel.deleteDespesa(id);
              Navigator.pop(context);
            },
          );
        });
  }

  Future<void> _navigateToPage(Widget page) => Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
