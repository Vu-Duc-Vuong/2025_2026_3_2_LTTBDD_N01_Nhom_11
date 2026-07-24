import 'package:flutter/material.dart';

class PetProfileScreen extends StatelessWidget {
  const PetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hồ sơ thú cưng"),
      ),
      body: const Center(
        child: Text("Pet Profile"),
      ),
    );
  }
}