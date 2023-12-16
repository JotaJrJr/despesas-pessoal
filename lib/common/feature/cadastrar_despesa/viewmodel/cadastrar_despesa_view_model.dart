import 'package:despesas/common/database/services/service_categoria_impl.dart';
import 'package:despesas/common/database/services/service_despesa_impl.dart';
import 'package:despesas/common/models/categoria_despesa_model.dart';
import 'package:despesas/common/models/despesa_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CadastrarDespesaViewModel extends ChangeNotifier {
  final ServiceDespesaImpl serviceDespesaImpl;
  final ServiceCategoriaImpl serviceCategoriaImpl;

  CadastrarDespesaViewModel({
    required this.serviceDespesaImpl,
    required this.serviceCategoriaImpl,
  });

  TextEditingController descricaoController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  TextEditingController categoriaDescricaoController = TextEditingController();

  List<DespesaModel> despesas = [];

  CategoriaModel? categoriaSelecionada;

  bool isCategoriaSelecionada = false;

  void preencherCategoriaSelecionada(CategoriaModel model) {
    categoriaSelecionada = model;
    isCategoriaSelecionada = true;
    notifyListeners();
  }

  void esvaziarCategoriaSelecionada() {
    categoriaSelecionada = null;
    isCategoriaSelecionada = false;
    notifyListeners();
  }

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

  bool canSaveCategoria() {
    if (categoriaDescricaoController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> insertCategoria() async {
    try {
      CategoriaModel model = CategoriaModel(
        id: const Uuid().v4(),
        descricao: categoriaDescricaoController.text,
      );

      await serviceCategoriaImpl.createCategoria(model);
    } catch (e) {
      throw (e);
    }
  }

  void deleteCategoriaById(String id) {
    serviceCategoriaImpl.deleteCategoria(id);
  }

  // Future<CategoriaModel> insertCategoria() {
  //   String idCategoria = Uuid().v4();

  //   try {
  //     if (categoriaDescricaoController.text.isNotEmpty) {
  //       CategoriaModel categoria = CategoriaModel(
  //         id: idCategoria,
  //         descricao: categoriaDescricaoController.text,
  //       );

  //     }
  //   } catch (e) {}
  // }

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
