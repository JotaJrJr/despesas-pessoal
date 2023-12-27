import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  final String label;

  final VoidCallback onTap;

  const GridItem({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool onPressed = false;

  @override
  Widget build(BuildContext context) {
    Color? color = Color(0xFF283852);

    return InkWell(
      onHighlightChanged: (value) => setState(() => onPressed = value),
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(8.5),
      highlightColor: color,
      hoverColor: color,
      splashColor: color,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color!),
          borderRadius: BorderRadius.circular(8.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search),
            const SizedBox(height: 20),
            Text(
              widget.label,
            ),
          ],
        ),
      ),
    );
  }
}
