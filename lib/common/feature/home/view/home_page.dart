import 'package:despesas/common/feature/cadastrar_despesa/view/cadastrar_despesa_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
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
          ),
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
                  onPressed: () => _navigateToPage(const CadastrarDespesaPage()),
                  child: const Text("Adicionar Despesa"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _navigateToPage(Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
}
