// import 'package:blood_link/authentication/auth_screen.dart';
// import 'package:blood_link/global/global.dart';
// import 'package:blood_link/models/UserModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   TextEditingController searchController = TextEditingController();

//   final bloodGroups = [
//     'A+',
//     'A-',
//     'B+',
//     'B-',
//     'O+',
//     'O-',
//     'AB+',
//     'AB-',
//     'BOMBAY'
//   ];
//   String? selectedGroup;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           TextField(
//             controller: searchController,
//             decoration: const InputDecoration(labelText: "Location"),
//           ),
//           DropdownButtonFormField(
//               icon: const Icon(Icons.bloodtype),
//               hint: const Text("Select Blood Group"),
//               items: bloodGroups
//                   .map((e) => DropdownMenuItem(
//                         value: e,
//                         child: Text(e),
//                       ))
//                   .toList(),
//               onChanged: (val) {
//                 selectedGroup = val;
//               }),
//           ElevatedButton(
//               onPressed: () {
//                 setState(() {});
//               },
//               child: const Text("Search")),
//           const SizedBox(
//             height: 10,
//           ),
//           StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection("donors")
//                 .where("address", isGreaterThanOrEqualTo: searchController.text)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.hasData) {
//                   QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

//                   if (dataSnapshot.docs.length > 0) {
//                     Map<String, dynamic> userMap =
//                         dataSnapshot.docs[0].data() as Map<String, dynamic>;

//                     UserModel searchedUser = UserModel.formMap(userMap);
//                     // return ListTile(
//                     //   leading: CircleAvatar(
//                     //     backgroundImage: NetworkImage(searchedUser.photo!),
//                     //   ),
//                     //   title: Text(searchedUser.name!),
//                     //   subtitle: Text(searchedUser.email!,),
//                     // );
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(searchedUser.photo!),
//                       ),
//                       title: Text(searchedUser.name!),
//                       subtitle: Text(
//                         "${searchedUser.email!}\n${searchedUser.group!}\n${searchedUser.phone!}\n${searchedUser.location!}",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       trailing: Icon(Icons.keyboard_arrow_right),
//                     );
//                   } else {
//                     return const Text("No results found!");
//                   }
//                 } else if (snapshot.hasError) {
//                   return const Text("An error occured!");
//                 } else {
//                   return const Text("No results found!");
//                 }
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             },
//           ),

//           const SizedBox(
//             height: 10,
//           ),
//           StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection("donors")
//                 .where("donorBloodGroup", isEqualTo: selectedGroup)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.hasData) {
//                   QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

//                   if (dataSnapshot.docs.length > 0) {
//                     Map<String, dynamic> userMap =
//                         dataSnapshot.docs[0].data() as Map<String, dynamic>;

import 'package:blood_link/models/users.dart';
//                     UserModel searchedUser = UserModel.formMap(userMap);
//                     return ListTile(
//                       tileColor: Colors.white,
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(searchedUser.photo!),
//                       ),
//                       title: Text(searchedUser.name!),
//                       subtitle: Text(
//                         "${searchedUser.email!}\n${searchedUser.group!}\n${searchedUser.phone!}\n${searchedUser.location!}",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       trailing: Icon(Icons.keyboard_arrow_right),
//                     );
//                     // return Container(
//                     //   padding: const EdgeInsets.all(10),
//                     //   width: double.infinity,
//                     //   height: 200,
//                     //   color: Colors.grey[100],
//                     //   child: Column(
//                     //     children: [
//                     //       CircleAvatar(
//                     //         radius: 40,
//                     //         backgroundImage: NetworkImage(searchedUser.photo!),
//                     //       ),
//                     //       Text(searchedUser.name!),
//                     //       Text(searchedUser.group!),
//                     //       Text(searchedUser.phone!),
//                     //       Text(searchedUser.location!),
//                     //        IconButton(
//                     //           onPressed: () {}, icon: Icon(Icons.message))
//                     //     ],
//                     //   ),
//                     // );
//                   } else {
//                     return const Text("No results found!");
//                   }
//                 } else if (snapshot.hasError) {
//                   return const Text("An error occured!");
//                 } else {
//                   return const Text("No results found!");
//                 }
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             },
//           ),
//           // StreamBuilder(
//           //     stream:
//           //         FirebaseFirestore.instance.collection("donors").snapshots(),
//           //     builder: (context, AsyncSnapshot snapshot) {
//           //       if (snapshot.hasData) {
//           //         return ListView.builder(
//           //           itemBuilder: (context, index) {
//           //             final DocumentSnapshot donorSnap =
//           //                 snapshot.data.docs[index];
//           //             return Text(donorSnap["donorName"]);
//           //           },
//           //           itemCount: snapshot.data.docs.length,
//           //         );
//           //       }
//           //       return Container();
//           //     }),
//           ElevatedButton(
//             onPressed: () {
//               firebaseAuth.signOut().then((value) {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (c) => const AuthScreen()));
//               });
//             },
//             style: ElevatedButton.styleFrom(
//               primary: Colors.red,
//             ),
//             child: const Text("Logout"),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:blood_link/widgets/user_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot>? postDocumentList;
  String userAddressText = '';

  initSearchDonor(String textEntered) {
    postDocumentList = FirebaseFirestore.instance
        .collection("donors")
        .where("address", isGreaterThanOrEqualTo: textEntered)
        .get();

    setState(() {
      postDocumentList;
    });
  }

  String? completeAddress = '';
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
    lat = position!.latitude;
    lng = position!.longitude;
    completeAddress =
        '${pMark.locality},${pMark.administrativeArea}${pMark.postalCode},${pMark.country}';
    locationController.text = completeAddress!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                getCurrentLocation();
              },
              icon: const Icon(
                Icons.my_location,
                color: Colors.red,
              ))
        ],
        backgroundColor: Colors.white,
        title: TextField(
          controller: locationController,
          onChanged: (textEntered) {
            setState(() {
              userAddressText = textEntered;
            });
            initSearchDonor(textEntered);
          },
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: const TextStyle(color: Colors.black),
            suffixIcon: IconButton(
                onPressed: () {
                  initSearchDonor(userAddressText);
                },
                icon: const Icon(Icons.search)),
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: postDocumentList,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Users model = Users.fromJson(snapshot.data!.docs[index]
                          .data()! as Map<String, dynamic>);
                      return UserDesign(
                        model: model,
                        context: context,
                      );
                    },
                  )
                : const Center(
                    child: Text("No Records Exist"),
                  );
          }),
    );
  }
}
