import 'package:flutter/material.dart';

class DropButton extends StatefulWidget {
  @override
  State<DropButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropButton> {
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
  String? SelectedGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              SelectedGroup = val;
            }));
  }
}
