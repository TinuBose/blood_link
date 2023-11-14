import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorDetails extends StatefulWidget {
  const DonorDetails({super.key});

  @override
  State<DonorDetails> createState() => _DonorDetailsState();
}

class _DonorDetailsState extends State<DonorDetails> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection("donors");

  void deleteDonor(docId) {
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: donor.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot donorSnap =
                        snapshot.data.docs[index];
                    if (donorSnap["donorEmail"] == "admin@gmail.com") {
                      return Container();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 80,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(donorSnap['donorAvatarUrl']),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    donorSnap["donorName"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    donorSnap["donorBloodGroup"],
                                  ),
                                  Text(donorSnap["donorPhone"]),
                                  Text(donorSnap["address"]),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        final Uri url = Uri(
                                          scheme: 'sms',
                                          path: donorSnap["donorPhone"],
                                        );
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        } else {
                                          print("cannot message");
                                        }
                                      },
                                      icon: const Icon(Icons.message)),
                                  IconButton(
                                      onPressed: () {
                                        deleteDonor(donorSnap.id);
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  });
            }
            return Container();
          }),
    );
  }
}
