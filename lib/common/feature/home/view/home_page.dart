import 'package:despesas/common/database/app_db.dart';
import 'package:despesas/common/database/services/service_despesa_impl.dart';
import 'package:despesas/common/feature/cadastrar_despesa/view/cadastrar_despesa_page.dart';
import 'package:despesas/common/feature/home/viewmodel/home_view_model.dart';
import 'package:despesas/common/models/despesa_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/safe_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
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
      ),
      body: Column(
        children: [
          AnimatedBuilder(
              animation: _viewModel,
              builder: (_, __) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: _viewModel.listaDespesas.length,
                    // itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DespesaModel despesa = _viewModel.listaDespesas[index];

                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              border: Border.all(
                                color: Colors.red,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(SafeHandler.value(despesa.descricao)),
                                  const Spacer(),
                                  Text(SafeHandler.value(formatCurrency(despesa.valor!))),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Text(SafeHandler.value(despesa.descricaoCategoria)),
                                  const Spacer(),
                                  despesa.data != null ? Text(SafeHandler.value(formatTimestamp(despesa.data!))) : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Filtrar"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Gráficos"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _navigateToPage(const CadastrarDespesaPage()).then((value) => _viewModel.fillListaDespesas()),
                  child: const Text("Adicionar Despesa"),
                ),
              ),
            ],
          )
        ],
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

  Future<void> _navigateToPage(Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
}
