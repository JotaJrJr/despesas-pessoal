import 'package:despesas/common/database/app_db.dart';
import 'package:despesas/common/database/tables/despesa.dart';
import 'package:drift/drift.dart';

part 'despesa_dao.g.dart';

@DriftAccessor(tables: [Despesa])
class DespesaDao extends DatabaseAccessor<AppDb> with _$DespesaDaoMixin {
  final AppDb db;

  DespesaDao(this.db) : super(db);

  Future<List<DespesaData>> getAll() => select(despesa).get();

  Future<List<DespesaData>> getAllByPerfil(int perfil) => (select(despesa)..where((tbl) => tbl.perfil.equals(perfil))).get();

  Stream<List<DespesaData>> watchAll() => select(despesa).watch();

  Future insert(Insertable<DespesaData> despesaData) => into(despesa).insert(despesaData);

  Future deleteById(String id) => (delete(despesa)..where((tbl) => tbl.id.equals(id))).go();

  Future getById(String id) => (select(despesa)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future modify(Insertable<DespesaData> model) => update(despesa).replace(model);

  Future insertOrUpdate(DespesaData data) async {
    return await (select(despesa)
          ..where((tbl) => tbl.id.equals(data.id))
          ..limit(1))
        .getSingleOrNull()
        .then((row) async {
      if (row != null) {
        return await modify(data);
      } else {
        return await insert(data);
      }
    });
  }

  Future<void> deleteAllDespesasByIdCategoria(String idCategoria) {
    return (delete(despesa)..where((tbl) => tbl.idCategoria.equals(idCategoria))).go();
  }
}
