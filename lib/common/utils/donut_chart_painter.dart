import 'dart:math';
// ignore: library_prefixes
import 'dart:ui' as txtDirec;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonutChartPainter extends CustomPainter {
  final Map<String?, num> values;
  final String valorTotal;

  late List<Color> segmentColors;

  late Paint midPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  late Paint linePaint;

  late TextStyle centeredStyle;

  DonutChartPainter({
    required this.values,
    required this.valorTotal,
  }) {
    midPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    linePaint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    centeredStyle = const TextStyle(
      color: Color(0xFF000000),
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );

    // Generate random colors here
    segmentColors = List.generate(values.length, (index) => getRandomColor());
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
        // ..color = getRandomColor();
        ..color = segmentColors[values.keys.toList().indexOf(element.key)];

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
