import 'package:despesas/common/database/daos/despesa_dao.dart';
import 'package:despesas/common/domain/services/service_despesa.dart';
import 'package:despesas/common/models/despesa_model.dart';

class ServiceDespesaImpl implements ServiceDespesa {
  final DespesaDao dao;

  ServiceDespesaImpl({required this.dao});

  @override
  Future<DespesaModel> createDespesa(DespesaModel model) {
    return dao.insert(model.toData()).then((value) => model);
  }

  @override
  Future<void> deleteDespesa(String id) {
    return dao.deleteById(id);
  }

  @override
  Future<DespesaModel> getById(String id) {
    return dao.getById(id).then((value) => value.map((e) => DespesaModel.fromData(value)));
  }

  @override
  Future<List<DespesaModel>> getDespesas() {
    return dao.getAll().then((value) => value.map((e) => DespesaModel.fromData(e)).toList());
  }

  @override
  Future insertOrUpdate(DespesaModel model, String? id) {
    return dao.insertOrUpdate(model.toData());
  }

  @override
  Stream<List<DespesaModel>> watchAll() async* {
    List<DespesaModel> list = [];

    await for (var data in dao.watchAll()) {
      list = data.map((e) => DespesaModel.fromData(e)).toList();
      yield list;
    }
  }
}
