import 'dart:math';
import 'dart:ui' as txtDirec;
import 'package:despesas/common/models/despesa_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

class DonutChartPainter extends CustomPainter {
  final Map<String?, num> values;
  final String valorTotal;

  late Paint midPaint;

  final linePaint = Paint()
    ..color = const Color.fromARGB(255, 255, 255, 255)
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;

  final centeredStyle = const TextStyle(
    color: Color(0xFF000000),
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  DonutChartPainter({required this.values, required this.valorTotal}) {
    midPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);

    const centeredStyle = TextStyle(
      color: Color(0xFF000000),
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

    // final totalValue = values.

    values.entries.fold((0.0), (previousValue, element) {
      final sweepAngle = element.value * 360 * pi / 180;
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = getRandomColor();

      canvas.drawArc(rect, previousValue, sweepAngle, true, paint);

      drawLinesArc(canvas, c, radius, previousValue);

      return sweepAngle + previousValue;
    });

    canvas.drawCircle(c, radius * 0.35, midPaint);
    drawTextCentered(canvas, c, formatCurrency(valorTotal), centeredStyle, radius * 0.6);
  }

  String formatCurrency(String numericString) {
    double numericValue = double.parse(numericString);

    NumberFormat currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    String formattedCurrency = currencyFormat.format(numericValue);

    return formattedCurrency;
  }

  TextPainter drawText(String text, TextStyle style, double maxWidth, TextAlign textAlign) {
    final span = TextSpan(text: text, style: style);
    final textPainter = TextPainter(text: span, textAlign: textAlign, maxLines: 2, textDirection: txtDirec.TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter;
  }

  Size drawTextCentered(Canvas canvas, Offset position, String text, TextStyle style, double maxWidth) {
    final textPainter = drawText(text, style, maxWidth, TextAlign.center);
    final pos = position + Offset(-textPainter.width / 2.0, -textPainter.height / 2.0);
    textPainter.paint(canvas, pos);
    return textPainter.size;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawLinesArc(Canvas canvas, Offset c, double radius, double startAngle) {
    final dx = radius / 2 * cos(startAngle);
    final dy = radius / 2 * sin(startAngle);
    final p2 = c + Offset(dx, dy);

    canvas.drawLine(c, p2, linePaint);
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }
}
