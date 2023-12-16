import 'dart:developer';

import 'package:despesas/common/database/services/service_categoria_impl.dart';
import 'package:despesas/common/database/services/service_despesa_impl.dart';
import 'package:despesas/common/models/categoria_despesa_model.dart';
import 'package:despesas/common/models/despesa_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CadastrarDespesaViewModel extends ChangeNotifier {
  TextEditingController descricaoController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  final ServiceDespesaImpl serviceDespesaImpl;
  final ServiceCategoriaImpl serviceCategoriaImpl;

  CadastrarDespesaViewModel({
    required this.serviceDespesaImpl,
    required this.serviceCategoriaImpl,
  });

  List<DespesaModel> despesas = [];

  Future<List<DespesaModel>> getAllDespesas() {
    return serviceDespesaImpl.getDespesas();
  }

  Stream<List<CategoriaModel>> watchAll() {
    return serviceCategoriaImpl.watchAll();
  }

  DespesaModel createModel() {
    String idDespesa = Uuid().v4();

    DespesaModel model = DespesaModel(
      id: idDespesa,
      descricao: descricaoController.text,
      valor: extractNumericValue(valorController.text),
    );

    return model;
  }

  bool canSave() {
    return descricaoController.text.isNotEmpty && valorController.text.isNotEmpty;
  }

  double extractNumericValue(String text) {
    // Remove non-numeric characters and replace commas with dots
    String cleanedText = text.replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(',', '.');

    // Parse the cleaned text to double
    try {
      return double.parse(cleanedText);
    } catch (e) {
      // Handle parsing error if necessary
      print("Error parsing numeric value: $e");
      return 0.0;
    }
  }
}
