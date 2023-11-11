import 'package:blood_link/global/global.dart';
import 'package:flutter/material.dart';

class SubHomeScreen extends StatefulWidget {
  const SubHomeScreen({super.key});

  @override
  State<SubHomeScreen> createState() => _SubHomeScreenState();
}

class _SubHomeScreenState extends State<SubHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            firebaseAuth.signOut();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red[900],
          ),
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
