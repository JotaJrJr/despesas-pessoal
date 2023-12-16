import 'package:despesas/common/database/app_db.dart';
import 'package:despesas/common/database/services/service_categoria_impl.dart';
import 'package:despesas/common/database/services/service_despesa_impl.dart';
import 'package:despesas/common/feature/cadastrar_despesa/viewmodel/cadastrar_despesa_view_model.dart';
import 'package:despesas/common/models/categoria_despesa_model.dart';
import 'package:despesas/common/utils/currency_formatter_utils.dart';
import 'package:despesas/common/widgets/text_field_currency_widget.dart';
import 'package:despesas/common/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastrarDespesaPage extends StatefulWidget {
  const CadastrarDespesaPage({super.key});

  @override
  State<CadastrarDespesaPage> createState() => _CadastrarDespesaPageState();
}

class _CadastrarDespesaPageState extends State<CadastrarDespesaPage> {
  late CadastrarDespesaViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CadastrarDespesaViewModel(
        serviceDespesaImpl: ServiceDespesaImpl(
          dao: Provider.of<AppDb>(context, listen: false).despesaDao,
        ),
        serviceCategoriaImpl: ServiceCategoriaImpl(
          dao: Provider.of<AppDb>(context, listen: false).categoriaDao,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Color containerColor = _viewModel.canSave() ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesa"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFieldWidget(
              controller: _viewModel.descricaoController,
            ),
            const SizedBox(height: 8),
            TextFieldCurrencyWidget(
              isCurrencyMoney: true,
              controller: _viewModel.valorController,
              textInputType: TextInputType.number,
              textInputFormatter: CurrencyPtBrInputFormatter(),
              // onChanged: () {},
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: const Text(
                  "Adicionar Despesa",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: const Text(
                  "Adicionar Categoria",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 300,
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Expanded(
                child: SizedBox(
                  child: StreamBuilder<List<CategoriaModel>>(
                    stream: _viewModel.watchAll(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // circular
                      }

                      if (snapshot.hasError) {
                        // deu ruim
                      }

                      final List<CategoriaModel> list = snapshot.data ?? [];
                      if (list.isEmpty) {
                        // vazio
                      }

                      // container com lista
                      return Container(
                        child: ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Text(
                                  list[index].id ?? "",
                                ),
                                Text(
                                  list[index].descricao ?? "",
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                  // child: ListView.builder(
                  //   itemCount: 10,
                  //   shrinkWrap: true,
                  //   itemBuilder: (context, index) {
                  //     return const Padding(
                  //       padding: EdgeInsets.all(4),
                  //       child: Card(
                  //         child: ListTile(
                  //           title: Text("TítuloAAA"),
                  //           subtitle: Text("Subtítulo"),
                  //           leading: Icon(Icons.money),
                  //           trailing: Icon(Icons.delete),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
