import 'dart:convert';

import 'package:despesas/common/models/despesa_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastrarDespesaViewModel {
  TextEditingController descricaoController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  List<DespesaModel> despesas = [];

  Future<void> getNotas() async {
    despesas.clear();

    List<DespesaModel> despesasList = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final despesasData = prefs.getString('despesas') ?? [];
    if (despesasData != null) {
      final List<dynamic> despesasJson = json.decode(despesasData);
      despesasList = despesasJson.map((e) => DespesaModel.fromJson(e)).toList();
    }

    despesas = despesasList;
  }
}
