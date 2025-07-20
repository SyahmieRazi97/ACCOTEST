import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

class WidgetNotes extends StatelessWidget {

  final String text;

  const WidgetNotes({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ArcText(
        radius: 180,
        text: text,
        textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
        startAngle: -1.2 / 2, // Start from the top (half circle)
        placement: Placement.outside,
      ),
    );
  }
}