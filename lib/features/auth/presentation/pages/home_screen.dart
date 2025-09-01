import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String? name;
  final String? email;
  final String? mobile;

  const HomeScreen({super.key, this.name, this.email, this.mobile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome, $name",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Email: $email", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Mobile: $mobile", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
