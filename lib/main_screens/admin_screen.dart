import 'package:blood_link/global/global.dart';
import 'package:blood_link/main_screens/sub_admin_screens.dart/admin_messages.dart';
import 'package:blood_link/main_screens/sub_admin_screens.dart/donor_details.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.red[900],
            title: Text(
              sharedPreferences!.getString("name")!,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  text: "Search",
                ),
              ],
              indicatorColor: Colors.white38,
              indicatorWeight: 6,
            ),
          ),
          body: Container(
            color: Colors.white,
            child:
                const TabBarView(//use tab bar since we are using tab bar view
                    children: [
              MessageScreen(),
              DonorDetails(),
            ]),
          ),
        ));
  }
}
