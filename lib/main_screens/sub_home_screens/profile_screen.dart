import 'package:blood_link/authentication/auth_screen.dart';
import 'package:blood_link/global/global.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage("photoUrl"),
          ),
          Center(
            child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }
}
