import 'dart:io';

import 'package:blood_link/authentication/auth_screen.dart';
import 'package:blood_link/global/global.dart';
import 'package:blood_link/main_screens/home_screen.dart';
import 'package:blood_link/widgets/error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
  String? status = '';
  String? weight = '';
  String? age = '';
  File? imageXFile;
  String? donorPhoneInput = '';
  String? donorAddresInput = '';
  String? donorWeightInput = '';
  String? donorStatusInput = '';
  double? lat = 0;
  double? lng = 0;
  TextEditingController locationController = TextEditingController();

  Position? position;
  List<Placemark>? placeMarks;

  getCurrentLocation() async {
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    position = newPosition;
    placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    Placemark pMark = placeMarks![0];
    donorAddresInput =
        '${pMark.locality},${pMark.administrativeArea}${pMark.postalCode},${pMark.country}'
            .toLowerCase();
    locationController.text = donorAddresInput!;
  }

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
          status = snapshot.data()!["status"];
          age = snapshot.data()!["donorAge"];
          lat = snapshot.data()!["lat"];
          lng = snapshot.data()!["lng"];
        });
      }
    });
  }

  Future _updateDonorName() async {
    await FirebaseFirestore.instance
        .collection("donors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"donorPhone": donorPhoneInput});
  }

  Future _updateDonorLocation() async {
    await FirebaseFirestore.instance
        .collection("donors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"address": donorAddresInput});
  }

  Future _updateLat() async {
    await FirebaseFirestore.instance
        .collection("donors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"lat": position!.latitude});
  }

  Future _updateLng() async {
    await FirebaseFirestore.instance
        .collection("donors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"lng": position!.longitude});
  }

  Future _updateDonorWeight() async {
    await FirebaseFirestore.instance
        .collection("donors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"weight": donorWeightInput});
  }

  Future _updateDonorStatus() async {
    await FirebaseFirestore.instance
        .collection("donors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"status": donorStatusInput});
  }

  _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update your number here"),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  donorPhoneInput = value;
                });
              },
              decoration: const InputDecoration(hintText: "Type here"),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _updateDonorName();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          );
        });
  }

  _displayAddressInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update your Address here"),
            content: TextField(
              controller: locationController,
              onChanged: (value) {
                setState(() {
                  value = locationController.text;
                });
              },
              decoration: const InputDecoration(hintText: "Type here"),
            ),
            actions: [
              ElevatedButton.icon(
                  onPressed: () {
                    getCurrentLocation();
                  },
                  icon: const Icon(Icons.location_on),
                  label: const Text("Location")),
              ElevatedButton(
                onPressed: () {
                  _updateDonorLocation();
                  _updateLat();
                  _updateLng();

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          );
        });
  }

  _displayWeightInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update your weight here"),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  donorWeightInput = value;
                });
              },
              decoration: const InputDecoration(hintText: "Type here"),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _updateDonorWeight();
                  if (double.parse(donorWeightInput!) < 45) {
                    donorStatusInput = "user";
                    _updateDonorStatus();
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          );
        });
  }

  _displayStatusInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update your status here"),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  donorStatusInput = value;
                });
              },
              decoration: const InputDecoration(hintText: "Type here"),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (donorStatusInput == "donor" ||
                      donorStatusInput == "user") {
                    _updateDonorStatus();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()));
                  } else {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(message: "You must be user/donor");
                        });
                  }
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          );
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
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email : ${email!}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
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
                      _displayTextInputDialog(context);
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
                      _displayAddressInputDialog(context);
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
                  "Current status : ${status}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      var dage = double.parse(age!);
                      var dweight = double.parse(weight!);
                      //edit text
                      if (dage >= 18 && dage <= 65) {
                        if (dweight >= 45) {
                          _displayStatusInputDialog(context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (c) {
                                return ErrorDialog(
                                    message: "Your weight doesnt match");
                              });
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (c) {
                              return ErrorDialog(
                                  message: "You age doesnt match");
                            });
                      }
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
                      //edit tex
                      _displayWeightInputDialog(context);
                    },
                    icon: const Icon(Icons.edit)),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}
