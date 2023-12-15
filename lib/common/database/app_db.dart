import 'dart:io';

import 'package:despesas/common/database/tables/categoria.dart';
import 'package:despesas/common/database/tables/despesa.dart';

import 'package:despesas/common/database/daos/categoria_dao.dart';
import 'package:despesas/common/database/daos/despesa_dao.dart';

import 'package:despesas/common/database/dao_list.dart';
import 'package:despesas/common/database/table_list.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_db.g.dart';

@DriftDatabase(tables: TableList.tables, daos: DaoList.daos)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase.createInBackground(file);
  });
}
