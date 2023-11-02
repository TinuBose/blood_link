import 'package:blood_link/widgets/custom_text_field.dart';
import 'package:blood_link/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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

  getCurrentLocation() async {
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    position = newPosition;
    placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    Placemark pMark = placeMarks![0];
    String completeAdress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

    locationController.text = completeAdress;
  }

  Future<void> formValidation() async {
    if (selectedGroup == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: "Select your blood group");
          });
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (confirmPasswordController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            locationController.text.isNotEmpty &&
            ageController.text.isNotEmpty &&
            selectedGroup!.isNotEmpty) {
          //select group
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
                  textInputType: TextInputType.emailAddress,
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
