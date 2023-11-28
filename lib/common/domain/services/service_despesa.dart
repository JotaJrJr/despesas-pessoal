import 'package:despesas/common/models/despesa_model.dart';

abstract class ServiceDespesa {
  Future<List<DespesaModel>> getDespesas();
  Future<DespesaModel> getDespesa(int id);
  Future<int> createDespesa(DespesaModel model);
  Future<DespesaModel> updateDespesa(int id, DespesaModel model);
  Future<int> deleteDespesa(int id);
}
