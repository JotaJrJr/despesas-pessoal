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

import '../../../utils/safe_handler.dart';

class CadastrarDespesaPage extends StatefulWidget {
  final int perfil;
  const CadastrarDespesaPage({super.key, required this.perfil});

  @override
  State<CadastrarDespesaPage> createState() => _CadastrarDespesaPageState();
}

class _CadastrarDespesaPageState extends State<CadastrarDespesaPage> {
  late CadastrarDespesaViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CadastrarDespesaViewModel(
        perfil: widget.perfil,
        serviceDespesaImpl: ServiceDespesaImpl(
          dao: Provider.of<AppDb>(context, listen: false).despesaDao,
        ),
        serviceCategoriaImpl: ServiceCategoriaImpl(
          dao: Provider.of<AppDb>(context, listen: false).categoriaDao,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesa"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text("Descrição da despesa"),
            const SizedBox(height: 4),
            TextFieldWidget(
              controller: _viewModel.descricaoController,
            ),
            const SizedBox(height: 8),
            const Text("Valor da despesa"),
            const SizedBox(height: 4),
            TextFieldCurrencyWidget(
              isCurrencyMoney: true,
              controller: _viewModel.valorController,
              textInputType: TextInputType.number,
              textInputFormatter: CurrencyPtBrInputFormatter(),
              // onChanged: () {},
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                _viewModel.insertDespesa(_viewModel.createModel());
                Navigator.pop(context);
              },
              child: Align(
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
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _viewModel,
              builder: (_, __) {
                return Visibility(
                  visible: _viewModel.isCategoriaSelecionada,
                  child: Column(
                    children: [
                      const Text("Categoria selecionada:"),
                      GestureDetector(
                        onTap: () {
                          _viewModel.esvaziarCategoriaSelecionada();
                          debugPrint("ADSADADASD");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.blue,
                            ),
                          ),
                          child: Text(SafeHandler.value(_viewModel.categoriaSelecionada?.descricao)),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => showCategoriaModalBottomSheet(),
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
            ),
            const SizedBox(height: 4),
            Expanded(
              child: SizedBox(
                child: StreamBuilder<List<CategoriaModel>>(
                  stream: _viewModel.watchAll(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return const Text("Deu ruim, não sei por quê");
                    }

                    final List<CategoriaModel> list = snapshot.data ?? [];
                    if (list.isEmpty) {
                      return const Center(
                        child: Text("Clica ali em cima pra adicionar\nE poder selecionar"),
                      );
                    }

                    // container com lista
                    return SizedBox(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(height: 4),
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _viewModel.preencherCategoriaSelecionada(list[index]),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Colors.blue,
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    list[index].descricao ?? "",
                                  ),
                                  IconButton(
                                    onPressed: () => _viewModel.deleteCategoriaById(list[index].id!),
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  showCategoriaModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              // height: 180,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldWidget(
                    controller: _viewModel.categoriaDescricaoController,
                  ),
                  const SizedBox(height: 12.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (_viewModel.canSaveCategoria()) {
                          Navigator.pop(context);
                          _viewModel.insertCategoria();
                          _viewModel.categoriaDescricaoController.clear();
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Calma lá'),
                                content: const Text('Tem que digitar o nome da categoria pra adicionar depois'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the Dialog
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: const Text(
                          "Adicionar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                ],
              ),
            ),
          );
        });
  }
}
