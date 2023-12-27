import 'package:despesas/common/models/despesa_model.dart';
import 'package:flutter/material.dart';

import '../../../database/services/service_despesa_impl.dart';

class ListaDespesasViewModel extends ChangeNotifier {
  final ServiceDespesaImpl serviceDespesaImpl;

  ListaDespesasViewModel({required this.serviceDespesaImpl});

  List<DespesaModel> listaDespesas = [];

  double get valorTotal => listaDespesas.fold<double>(0, (previousValue, element) => previousValue + (element.valor ?? 0));

  void fillListaDespesas() async {
    listaDespesas = await serviceDespesaImpl.getDespesas();
    listaDespesas.sort((a, b) => (a.data ?? 0).compareTo(b.data ?? 0));
    notifyListeners();
  }

  void deleteDespesa(String id) async {
    await serviceDespesaImpl.deleteDespesa(id);
    fillListaDespesas();
    notifyListeners();
  }

  Map<K, List<T>> groupBy<T, K>(Iterable<T> items, K Function(T) keySelector) {
    Map<K, List<T>> groupedMap = {};

    for (var item in items) {
      var key = keySelector(item);
      groupedMap.putIfAbsent(key, () => []).add(item);
    }

    return groupedMap;
  }
}
