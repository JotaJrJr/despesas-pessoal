import 'package:despesas/common/database/daos/categoria_dao.dart';
import 'package:despesas/common/domain/services/service_categoria.dart';
import 'package:despesas/common/models/categoria_despesa_model.dart';

class ServiceCategoriaImpl implements ServiceCategoria {
  final CategoriaDao dao;

  ServiceCategoriaImpl({required this.dao});

  @override
  Future<CategoriaModel> createCategoria(CategoriaModel model) {
    return dao.insert(model.toData()).then((value) => CategoriaModel.fromData(value));
  }

  @override
  Future<void> deleteCategoria(String id) {
    return dao.deleteById(id);
  }

  @override
  Future<CategoriaModel> getById(String id) {
    return dao.getById(id).then((value) => value.map((e) => CategoriaModel.fromData(value)));
  }

  @override
  Future<List<CategoriaModel>> getCategorias() {
    return dao.getAll().then((value) => value.map((e) => CategoriaModel.fromData(e)).toList());
  }

  @override
  Future insertOrUpdate(CategoriaModel model, String? id) {
    return dao.insertOrUpdate(model.toData());
  }

  @override
  Stream<List<CategoriaModel>> watchAll() async* {
    List<CategoriaModel> list = [];

    await for (var data in dao.watchAll()) {
      list = data.map((e) => CategoriaModel.fromData(e)).toList();
      yield list;
    }
  }
}
