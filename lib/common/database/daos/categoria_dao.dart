import 'package:despesas/common/database/app_db.dart';
import 'package:despesas/common/database/tables/categoria.dart';
import 'package:drift/drift.dart';

part 'categoria_dao.g.dart';

@DriftAccessor(tables: [Categoria])
class CategoriaDao extends DatabaseAccessor<AppDb> with _$CategoriaDaoMixin {
  final AppDb db;

  CategoriaDao(this.db) : super(db);

  Future<List<CategoriaData>> getAll() => select(categoria).get();

  Stream<List<CategoriaData>> watchAll() => select(categoria).watch();

  Future insert(Insertable<CategoriaData> despesaData) => into(categoria).insert(despesaData);

  Future deleteById(String id) => (delete(categoria)..where((tbl) => tbl.id.equals(id))).go();

  Future getById(String id) => (select(categoria)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future modify(Insertable<CategoriaData> model) => update(categoria).replace(model);

  Future insertOrUpdate(CategoriaData data) async {
    return await (select(categoria)
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
}
