import 'package:blood_link/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String message;

  LoadingDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          const SizedBox(
            height: 10,
          ),
          Text(message! + " , Please wait..."),
        ],
      ),
    );
  }
}
