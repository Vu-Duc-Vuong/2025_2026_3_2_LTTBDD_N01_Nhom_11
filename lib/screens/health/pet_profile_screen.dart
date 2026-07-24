import 'package:flutter/material.dart';

class PetProfileScreen extends StatelessWidget {
  const PetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Hồ sơ thú cưng",
        ),
      ),

      body: const Center(
        child: Text(
          "Thông tin hồ sơ thú cưng",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),

    );
  }
}