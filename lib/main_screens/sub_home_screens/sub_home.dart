import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubHomeScreen extends StatefulWidget {
  const SubHomeScreen({super.key});

  @override
  State<SubHomeScreen> createState() => _SubHomeScreenState();
}

class _SubHomeScreenState extends State<SubHomeScreen> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection("donors");
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
                    return Container(
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                  onPressed: () {}, icon: Icon(Icons.phone))
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Container();
          }),
    );
  }
}
