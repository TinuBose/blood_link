import 'package:blood_link/authentication/auth_screen.dart';
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
    return SingleChildScrollView(
      child: Column(children: [
        ElevatedButton(
          onPressed: () {
            firebaseAuth.signOut().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const AuthScreen()));
            });
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: const Text("Logout"),
        ),
      ]),
    );
  }
}
