import 'package:despesas/common/database/services/service_despesa_impl.dart';
import 'package:despesas/common/database/tables/despesa.dart';
import 'package:despesas/common/models/despesa_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CadastrarDespesaViewModel {
  TextEditingController descricaoController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  final ServiceDespesaImpl serviceDespesaImpl;

  CadastrarDespesaViewModel({required this.serviceDespesaImpl});

  List<DespesaModel> despesas = [];

  Future<List<DespesaModel>> getAllDespesas() {
    return serviceDespesaImpl.getDespesas();
  }

  DespesaModel createModel() {
    String idDespesa = Uuid().v4();

    DespesaModel model = DespesaModel(
      id: idDespesa,
      descricao: descricaoController.text,
      valor: double.tryParse(valorController.text),
    );

    return model;
  }

  // Future createDespesa() {

  //   // Enviar para banco local
  //   try {
  //     serviceDespesaImpl.createDespesa(model)
  //   } catch(e) {
  //     throw(e);
  //   }
  // }
}
