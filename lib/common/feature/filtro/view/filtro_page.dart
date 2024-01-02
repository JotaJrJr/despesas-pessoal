import 'package:flutter/material.dart';

class FiltroPage extends StatefulWidget {
  const FiltroPage({super.key});

  @override
  State<FiltroPage> createState() => _FiltroPageState();
}

class _FiltroPageState extends State<FiltroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtro"),
      ),
    );
  }
}
