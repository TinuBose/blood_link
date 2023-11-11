import 'package:blood_link/global/global.dart';
import 'package:blood_link/main_screens/sub_home_screens/profile_screen.dart';
import 'package:blood_link/main_screens/sub_home_screens/sub_home.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    Icons.person,
                    color: Colors.white,
                  ),
                  text: "Profile",
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
              SubHomeScreen(),
              ProfileScreen(),
            ]),
          ),
        ));
  }
}
