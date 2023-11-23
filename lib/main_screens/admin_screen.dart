import 'dart:io';

import 'package:blood_link/main_screens/sub_admin_screens.dart/admin_messages.dart';
import 'package:blood_link/main_screens/sub_admin_screens.dart/donor_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  Future<QuerySnapshot>? postDocumentList;
  String userEmailText = '';

  initSearchDonor(String textEntered) {
    postDocumentList = FirebaseFirestore.instance
        .collection("donors")
        .where("donorEmail", isGreaterThanOrEqualTo: textEntered)
        .get();

    setState(() {
      postDocumentList;
    });
  }

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
                          Navigator.of(context).pop(true);
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
                "admin",
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
                      Icons.message,
                      color: Colors.white,
                    ),
                    text: "Messages",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                    text: "Donors",
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
                MessageScreen(),
                DonorDetails(),
              ]),
            ),
          )),
    );
  }
}
