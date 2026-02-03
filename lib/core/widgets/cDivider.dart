import 'package:flutter/material.dart';

class Cdivider extends StatelessWidget {
  const Cdivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.4,
      height: 2,
      color: const Color.fromARGB(255, 223, 223, 223),
    );
  }
}
