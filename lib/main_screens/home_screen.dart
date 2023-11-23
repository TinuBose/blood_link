import 'dart:io';

import 'package:blood_link/global/global.dart';
import 'package:blood_link/main_screens/sub_home_screens/profile_screen.dart';
import 'package:blood_link/main_screens/sub_home_screens/search_screen.dart';
import 'package:blood_link/main_screens/sub_home_screens/sub_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text("Do you really want to exit?"),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("No")),
                  ElevatedButton(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          Navigator.of(context).pop(true);
                          SystemNavigator.pop();
                        }
                      },
                      child: const Text("Yes"))
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: DefaultTabController(
          length: 3,
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
                  Tab(
                    icon: Icon(
                      Icons.person_2,
                      color: Colors.white,
                    ),
                    text: "My Profile",
                  ),
                ],
                indicatorColor: Colors.white38,
                indicatorWeight: 6,
              ),
            ),
            body: Container(
              color: Colors.white,
              child: const TabBarView(
                  //use tab bar since we are using tab bar view
                  children: [SubHomeScreen(), SearchScreen(), ProfileScreen()]),
            ),
          )),
    );
  }
}
