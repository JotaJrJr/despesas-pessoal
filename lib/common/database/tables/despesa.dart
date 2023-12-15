import 'package:drift/drift.dart';

class Despesa extends Table {
  TextColumn get id => text().named("ID")();
  TextColumn get descricao => text().nullable().named("DESCRICAO")();
  RealColumn get valor => real().nullable().named("VALOR")();
  IntColumn get data => integer().nullable().named("DATA")();
  TextColumn get idCategoria => text().nullable().named("ID_CATEGORIA")();
  BoolColumn get sincronizado => boolean().nullable().named("SINCRONIZADO")();
}
