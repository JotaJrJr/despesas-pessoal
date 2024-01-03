import 'package:despesas/common/database/services/service_categoria_impl.dart';
import 'package:despesas/common/models/categoria_despesa_model.dart';

class ListaCategoriaViewModel {
  final ServiceCategoriaImpl serviceCategoriaImpl;

  ListaCategoriaViewModel({
    required this.serviceCategoriaImpl,
  });

  Stream<List<CategoriaModel>> watchAll() {
    return serviceCategoriaImpl.watchAll();
  }

  void deleteCategoriaById(String id) {
    serviceCategoriaImpl.deleteCategoria(id);
  }
}
