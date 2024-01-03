import 'package:despesas/common/database/app_db.dart';
import 'package:despesas/common/database/services/service_categoria_impl.dart';
import 'package:despesas/common/feature/categoria/viewmodel/lista_categoria_view_model.dart';
import 'package:despesas/common/models/categoria_despesa_model.dart';
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
                              onPressed: () => _viewModel.deleteCategoriaById(list[index].id!),
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
        ],
      ),
    );
  }
}
