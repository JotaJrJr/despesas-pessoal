import 'package:despesas/common/database/app_db.dart';
import 'package:despesas/common/database/services/service_categoria_impl.dart';
import 'package:despesas/common/database/services/service_despesa_impl.dart';
import 'package:despesas/common/feature/categoria/viewmodel/lista_categoria_view_model.dart';
import 'package:despesas/common/models/categoria_despesa_model.dart';
import 'package:despesas/common/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaCategoriaPage extends StatefulWidget {
  const ListaCategoriaPage({super.key});

  @override
  State<ListaCategoriaPage> createState() => _ListaCategoriaPageState();
}

class _ListaCategoriaPageState extends State<ListaCategoriaPage> {
  late ListaCategoriaViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ListaCategoriaViewModel(
      serviceCategoriaImpl: ServiceCategoriaImpl(dao: Provider.of<AppDb>(context, listen: false).categoriaDao),
      serviceDespesaImpl: ServiceDespesaImpl(dao: Provider.of<AppDb>(context, listen: false).despesaDao),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
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
                    child: Text("Clica em cadastrar para adicionar um tipo de categoria."),
                  );
                }

                return SizedBox(
                    child: ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
                              onPressed: () => showConfirmationDialog(list[index].id ?? ""),
                              icon: const Icon(Icons.delete),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => showCategoriaModalBottomSheet(),
                child: const Text("Cadastrar"),
              ),
            ),
          ),
          const SizedBox(height: 18.0),
        ],
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

  void showConfirmationDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmação"),
          content: const Text("Apagando esta categoria, você também apagará as despesas desse tipo. Deseja continuar?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Não"),
            ),
            TextButton(
              onPressed: () {
                _viewModel.deleteAllDespesasByIdCategoria(id);
                _viewModel.deleteCategoriaById(id);
                Navigator.pop(context);
              },
              child: const Text("Sim"),
            ),
          ],
        );
      },
    );
  }
}
