import 'package:despesas/common/feature/lista_despesas/view/lista_despesas_page.dart';
import 'package:despesas/common/feature/perfil/widget/perfil_choice_widget.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  int currentProfile = 1;

  bool onPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 60.0),
            PerfilChoiceWidget(
              currentProfile: currentProfile,
              onProfileSelected: (profile) {
                setState(() {
                  currentProfile = profile;
                });
              },
            ),
            const SizedBox(height: 50),
            InkWell(
              highlightColor: Colors.blue,
              splashColor: Colors.blue,
              onHighlightChanged: (value) => setState(() => onPressed = value),
              onTap: () => {
                Future.delayed(const Duration(milliseconds: 250), () {
                  _navigateToPage(const ListaDespesasPage());
                })
              },
              child: Container(
                width: double.infinity,
                height: 80.0,
                decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.blue)),
                child: const Center(
                  child: Text("Visualizar Despesas"),
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: Text("Cadastrar Despesas"),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToPage(Widget page) => Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
