import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      color: const Color(0xFF384057), // Dark Gray Blue
      child: const Text(
        'Herrera Sanchez Valeria. 2026 6°I',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFFB3B3B3), // Silver Gray
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
