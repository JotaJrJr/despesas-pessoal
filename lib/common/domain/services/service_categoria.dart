import 'package:despesas/common/models/categoria_despesa_model.dart';

abstract class ServiceCategoria {
  Future<List<CategoriaModel>> getCategorias();
  Future<CategoriaModel> getById(String id);
  Future<CategoriaModel> createCategoria(CategoriaModel model);
  Future insertOrUpdate(CategoriaModel model, String? id);
  Future<void> deleteCategoria(String id);
  Stream<List<CategoriaModel>> watchAll();
}
