import 'package:despesas/common/models/despesa_model.dart';

abstract class ServiceDespesa {
  Future<List<DespesaModel>> getDespesas();
  Future<List<DespesaModel>> getAllByPerfil(int perfil);
  Future<DespesaModel> getById(String id);
  Future<DespesaModel> createDespesa(DespesaModel model);
  Future insertOrUpdate(DespesaModel model, String? id);
  Future<void> deleteDespesa(String id);
  Stream<List<DespesaModel>> watchAll();
  Future<void> deleteAllDespesasByIdCategoria(String idCategoria);
}
