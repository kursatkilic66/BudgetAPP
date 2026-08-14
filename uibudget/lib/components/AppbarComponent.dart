import 'package:flutter/material.dart';

class Appbarcomponent extends StatelessWidget {
  const Appbarcomponent({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(12),
      child: AppBar(
        title: const Text(
          "Budget App",
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [Icon(Icons.notifications)],
      ),
    );
  }
}
