import 'package:despesas/common/database/services/service_categoria_impl.dart';
import 'package:despesas/common/database/services/service_despesa_impl.dart';
import 'package:despesas/common/models/categoria_despesa_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ListaCategoriaViewModel {
  final ServiceCategoriaImpl serviceCategoriaImpl;
  final ServiceDespesaImpl serviceDespesaImpl;

  TextEditingController categoriaDescricaoController = TextEditingController();

  ListaCategoriaViewModel({
    required this.serviceCategoriaImpl,
    required this.serviceDespesaImpl,
  });

  Stream<List<CategoriaModel>> watchAll() {
    return serviceCategoriaImpl.watchAll();
  }

  void deleteCategoriaById(String id) {
    serviceCategoriaImpl.deleteCategoria(id);
  }

  void deleteAllDespesasByIdCategoria(String idCategoria) {
    serviceDespesaImpl.deleteAllDespesasByIdCategoria(idCategoria);
  }

  bool canSaveCategoria() {
    return categoriaDescricaoController.text.isNotEmpty;
  }

  Future<void> insertCategoria() async {
    try {
      CategoriaModel model = CategoriaModel(
        id: const Uuid().v4(),
        descricao: categoriaDescricaoController.text,
      );

      await serviceCategoriaImpl.createCategoria(model);
    } catch (e) {
      rethrow;
    }
  }
}
