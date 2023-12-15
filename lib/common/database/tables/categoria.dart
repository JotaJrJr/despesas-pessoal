import 'package:drift/drift.dart';

class Categoria extends Table {
  TextColumn get id => text().named("ID")();
  TextColumn get descricao => text().nullable().named("DESCRICAO")();
}
