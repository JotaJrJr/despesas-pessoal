import 'package:despesas/common/models/despesa_model.dart';
import 'package:despesas/common/utils/donut_chart_painter.dart';
import 'package:flutter/material.dart';

class DonutChartWidget extends StatelessWidget {
  final List<DespesaModel> despesas;
  final String valorTotal;

  const DonutChartWidget({super.key, required this.despesas, required this.valorTotal});

  num sum<T>(Iterable<T> items, num Function(T element) function, {num startValue = 0}) {
    return items.fold(startValue, (previousValue, element) => previousValue + function(element));
  }

  num get totalValue => despesas.fold<num>(0, (previousValue, element) => previousValue + (element.valor ?? 0));

  Map<String?, num> get grupoValues {
    var agrupado = groupBy(despesas, (e) => e.descricao);

    agrupado.removeWhere((key, value) => key == null);

    var lista = agrupado.map((key, value) => MapEntry(key, sum(value, (x) => x.valor ?? 0) / totalValue));

    return lista;
  }

  Map<K, List<T>> groupBy<T, K>(Iterable<T> items, K Function(T) keySelector) {
    Map<K, List<T>> groupedMap = {};

    for (var item in items) {
      var key = keySelector(item);
      groupedMap.putIfAbsent(key, () => []).add(item);
    }

    return groupedMap;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: DonutChartPainter(values: grupoValues, valorTotal: valorTotal),
      ),
    );
  }
}
