import 'package:despesas/common/database/tables/categoria.dart';
import 'package:despesas/common/database/tables/despesa.dart';

class TableList {
  static const List<Type> tables = [
    Despesa,
    Categoria,
  ];
}
