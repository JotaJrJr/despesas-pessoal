import 'package:despesas/common/database/daos/categoria_dao.dart';
import 'package:despesas/common/database/daos/despesa_dao.dart';

class DaoList {
  static const List<Type> daos = [
    DespesaDao,
    CategoriaDao,
  ];
}
