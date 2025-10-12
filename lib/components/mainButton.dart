import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;

  const MainButton({
    super.key,
    required this.label,
    this.onPressed,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xFFF7931A);

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return baseColor.withValues(alpha: 0.6);
            } else {
              return baseColor;
            }
          }),
          foregroundColor: WidgetStateProperty.all(Colors.black),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        child:
            loading
                ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                : Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Jura',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
      ),
    );
  }
}
