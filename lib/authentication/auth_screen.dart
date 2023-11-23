import 'dart:io';

import 'package:blood_link/authentication/login.dart';
import 'package:blood_link/authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text("Do you really want to exit?"),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("No")),
                  ElevatedButton(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        }
                      },
                      child: const Text("Yes"))
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.red[900],
              title: const Text(
                "BloodLink",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    text: "Login",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person_add,
                      color: Colors.white,
                    ),
                    text: "Register",
                  ),
                ],
                indicatorColor: Colors.white38,
                indicatorWeight: 6,
              ),
            ),
            body: Container(
              color: Colors.white,
              child:
                  const TabBarView(//use tab bar since we are using tab bar view
                      children: [
                LoginScreen(),
                RegisterScreen(),
              ]),
            ),
          )),
    );
  }
}
