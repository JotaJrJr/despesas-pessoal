import 'package:despesas/common/feature/cadastrar_despesa/viewmodel/cadastrar_despesa_view_model.dart';
import 'package:despesas/common/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

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
    _viewModel = CadastrarDespesaViewModel();
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
          children: [
            TextFieldWidget(
              controller: _viewModel.descricaoController,
            ),
            const SizedBox(height: 8),
            TextFieldWidget(
              controller: _viewModel.valorController,
            ),

            // Área que vai mostrar o tipo de despesa

            ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(4),
                  child: Card(
                    child: ListTile(
                      title: Text("Título"),
                      subtitle: Text("Subtítulo"),
                      leading: Icon(Icons.money),
                      trailing: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
