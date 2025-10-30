import 'package:flutter/material.dart';

class WidgetSectionView extends StatefulWidget {
  const WidgetSectionView({super.key});

  @override
  State<WidgetSectionView> createState() => _WidgetSectionViewState();
}

class _WidgetSectionViewState extends State<WidgetSectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.white, // Set your desired border color here
          width: 0.5, // Optional: Set the border width
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Assets",
              style: TextStyle(fontFamily: "Jura", fontSize: 16),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}