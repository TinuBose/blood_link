import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name = '';
  String? email = '';
  String? phone = '';
  String? image = '';
  String? address = '';
  String? readyToDonate = '';
  double? weight = 0;
  File? imageXFile;

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("donors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["donorName"];
          email = snapshot.data()!["donorEmail"];
          phone = snapshot.data()!["donorPhone"];
          image = snapshot.data()!["donorAvatarUrl"];
          address = snapshot.data()!["address"];
          readyToDonate = snapshot.data()!["readyToDonate"];
          weight = snapshot.data()!["weight"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {
                //show imgage dialog
              },
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 60,
                backgroundImage: imageXFile == null
                    ? NetworkImage(image!)
                    : Image.file(imageXFile!).image,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name : ${name!}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      //edit text
                    },
                    icon: const Icon(Icons.edit)),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email : ${email!}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      //edit text
                    },
                    icon: const Icon(Icons.edit)),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Phone : ${phone!}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      //edit text
                    },
                    icon: const Icon(Icons.edit)),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Address : ${address!}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      //edit text
                    },
                    icon: const Icon(Icons.edit)),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ready To Donate : ${readyToDonate!}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      //edit text
                    },
                    icon: const Icon(Icons.edit)),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Current Weight : ${weight!}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      //edit text
                    },
                    icon: const Icon(Icons.edit)),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
