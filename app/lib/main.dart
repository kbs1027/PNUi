import 'package:app/view/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Landing());
}

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: home(),
    );
  }
}
