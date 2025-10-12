import 'package:flutter/material.dart';

class MainTextField extends StatefulWidget {
  final String? value;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final Color fillColor;
  final double fontSize;

  const MainTextField({
    super.key,
    this.value,
    this.hintText = "0x..",
    this.onChanged,
    this.fillColor = const Color(0xFF373737),
    this.fontSize = 16,
  });

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      style: TextStyle(
        fontFamily: 'Jura',
        fontSize: widget.fontSize,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: 'Jura',
          fontSize: widget.fontSize,
          color: Colors.white70,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        isDense: true,
      ),
    );
  }
}
