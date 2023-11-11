import 'package:blood_link/authentication/auth_screen.dart';
import 'package:blood_link/global/global.dart';
import 'package:blood_link/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(labelText: "Blood Group, Location"),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text("Search")),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("donors")
                .where("address", isGreaterThanOrEqualTo: searchController.text)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                  if (dataSnapshot.docs.length > 0) {
                    Map<String, dynamic> userMap =
                        dataSnapshot.docs[0].data() as Map<String, dynamic>;

                    UserModel searchedUser = UserModel.formMap(userMap);
                    // return ListTile(
                    //   leading: CircleAvatar(
                    //     backgroundImage: NetworkImage(searchedUser.photo!),
                    //   ),
                    //   title: Text(searchedUser.name!),
                    //   subtitle: Text(searchedUser.email!,),
                    // );
                    return Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[100],
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(searchedUser.photo!),
                          ),
                          Text(searchedUser.name!),
                          Text(searchedUser.group!),
                          Text(searchedUser.phone!),
                          Text(searchedUser.location!),
                        ],
                      ),
                    );
                  } else {
                    return const Text("No results found!");
                  }
                } else if (snapshot.hasError) {
                  return const Text("An error occured!");
                } else {
                  return const Text("No results found!");
                }
              } else {
                return CircularProgressIndicator();
              }
            },
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
    );
  }
}
