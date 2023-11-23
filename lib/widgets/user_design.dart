import 'package:blood_link/global/global.dart';
import 'package:blood_link/models/users.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDesign extends StatefulWidget {
  Users? model;
  BuildContext? context;

  UserDesign({this.model, this.context});

  @override
  State<UserDesign> createState() => _UserDesignState();
}

class _UserDesignState extends State<UserDesign> {
  @override
  Widget build(BuildContext context) {
    if (widget.model!.donorEmail == sharedPreferences!.getString("email")) {
      return Container();
    } else {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.model!.donorAvatarUrl!),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.model!.donorName!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.model!.donorBloodGroup!,
                  style: const TextStyle(color: Colors.red),
                ),
                Text(widget.model!.donorPhone!),
                Text(widget.model!.donorEmail!),
                Text(widget.model!.status!),
                Text(widget.model!.address!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          final Uri url = Uri(
                            scheme: "tel",
                            path: widget.model!.donorPhone,
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            print("cannot dial");
                          }
                        },
                        icon: const Icon(Icons.phone)),
                    IconButton(
                        onPressed: () async {
                          final Uri url = Uri(
                            scheme: 'sms',
                            path: widget.model!.donorPhone,
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            print("cannot message");
                          }
                        },
                        icon: const Icon(Icons.message))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
