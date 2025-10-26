import 'package:flutter/material.dart';

class PercentPill extends StatelessWidget {
  const PercentPill({
    super.key,
    required this.value, // e.g. 2.78 for +2.78%
    this.fontSize = 12,
    this.borderRadius = 2,
  });

  /// Percent value in plain units (2.78 -> "2.78%")
  final double value;
  final double fontSize;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final bool isPositive = value > 0;
    final Color fg = isPositive ? Color(0xff6CCF59) : Color(0xffCF5959);
    final Color bg = isPositive ? Color(0xff121E14) : Color(0xff1E1212);

    final String text =
        "${isPositive ? '+' : ''}${value.toStringAsFixed(2)} %";

    return Container(
      width: 56,
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Align(
        child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Jura',
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
      )
    );
  }
}