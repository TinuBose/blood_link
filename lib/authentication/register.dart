import 'dart:io';

import 'package:blood_link/global/global.dart';
import 'package:blood_link/main_screens/home_screen.dart';
import 'package:blood_link/widgets/custom_text_field.dart';
import 'package:blood_link/widgets/error_dialog.dart';
import 'package:blood_link/widgets/loading_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  final bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
    'BOMBAY'
  ];
  String? selectedGroup;

  Position? position;
  List<Placemark>? placeMarks;
  String donorImageUrl = "";
  String completeAddress = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  getCurrentLocation() async {
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    position = newPosition;
    placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    Placemark pMark = placeMarks![0];
    completeAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

    locationController.text = completeAddress;
  }

  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: "Select an Image");
          });
    } else {
      if (selectedGroup == null) {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(message: "Select your Blood Group");
            });
      } else {
        if (passwordController.text == confirmPasswordController.text) {
          if (confirmPasswordController.text.isNotEmpty &&
              emailController.text.isNotEmpty &&
              nameController.text.isNotEmpty &&
              phoneController.text.isNotEmpty &&
              locationController.text.isNotEmpty &&
              ageController.text.isNotEmpty) {
            showDialog(
                context: context,
                builder: (c) {
                  return LoadingDialog(message: "Registering your account...");
                });

            String fileName = DateTime.now().millisecondsSinceEpoch.toString();
            fStorage.Reference reference = fStorage.FirebaseStorage.instance
                .ref()
                .child("donors")
                .child(fileName);
            fStorage.UploadTask uploadTask =
                reference.putFile(File(imageXFile!.path));
            fStorage.TaskSnapshot taskSnapshot =
                await uploadTask.whenComplete(() => () {});
            await taskSnapshot.ref.getDownloadURL().then((url) {
              donorImageUrl = url;

              //save information to firestore database
              signUpAuthenticateDonor();
            });
          } else {
            showDialog(
                context: context,
                builder: (c) {
                  return ErrorDialog(message: "All fields are required!");
                });
          }
        } else {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorDialog(message: "Password do not match");
              });
        }
      }
    }
  }

  Future<void> signUpAuthenticateDonor() async {
    User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: error.message.toString());
          });
    });
    if (currentUser != null) {
      saveDataToFireStore(currentUser!).then((value) {
        Navigator.pop(context);
        //send user to home page
        Route newRoute = MaterialPageRoute(builder: (c) => const HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFireStore(User currentUser) async {
    FirebaseFirestore.instance.collection("donors").doc(currentUser.uid).set({
      "donorUID": currentUser.uid,
      "donorEmail": currentUser.email,
      "donorName": nameController.text.trim(),
      "donorAvatarUrl": donorImageUrl,
      "donorAge": ageController.text.trim(),
      "donorPhone": phoneController.text.trim(),
      "donorBloodGroup": selectedGroup,
      "address": completeAddress,
      "status": "approved",
      "weight": 0.0,
      "readyToDonate": "yes",
      "lat": position!.latitude,
      "lng": position!.longitude,
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", donorImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    _getImage();
                  },
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.20,
                    backgroundColor: Colors.grey,
                    backgroundImage: imageXFile == null
                        ? null
                        : FileImage(File(imageXFile!.path)),
                    child: imageXFile == null
                        ? Icon(
                            Icons.add_a_photo,
                            size: MediaQuery.of(context).size.width * 0.20,
                            color: Colors.red,
                          )
                        : null,
                  ),
                ),
                CustomTextField(
                  data: Icons.person,
                  controller: nameController,
                  hintText: "Full Name",
                  isObscre: false,
                  maxlength: 20,
                  textInputType: TextInputType.name,
                ),
                CustomTextField(
                  data: Icons.calendar_view_day_rounded,
                  controller: ageController,
                  hintText: "age",
                  isObscre: false,
                  maxlength: 2,
                  textInputType: TextInputType.number,
                ),
                CustomTextField(
                  data: Icons.phone,
                  controller: phoneController,
                  hintText: "Phone",
                  isObscre: false,
                  maxlength: 10,
                  textInputType: TextInputType.phone,
                ),
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(10),
                    child: DropdownButtonFormField(
                        icon: const Icon(Icons.bloodtype),
                        hint: const Text("Select Your Blood Group"),
                        items: bloodGroups
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (val) {
                          selectedGroup = val;
                        })),
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObscre: false,
                  maxlength: 30,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObscre: true,
                  maxlength: 20,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  isObscre: true,
                  maxlength: 20,
                ),
                CustomTextField(
                  data: Icons.my_location,
                  controller: locationController,
                  hintText: "Your Location",
                  isObscre: false,
                  enabled: true,
                ),
                Container(
                  width: 200,
                  height: 40,
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      getCurrentLocation();
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    label: const Text("Access My Location"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              formValidation();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red[900],
            ),
            child: const Text(
              "Register",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
