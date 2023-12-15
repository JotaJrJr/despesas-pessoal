import 'package:despesas/common/models/despesa_model.dart';

abstract class ServiceDespesa {
  Future<List<DespesaModel>> getDespesas();
  Future<DespesaModel> getById(String id);
  Future<DespesaModel> createDespesa(DespesaModel model);
  Future insertOrUpdate(DespesaModel model, String? id);
  Future<void> deleteDespesa(String id);
}
