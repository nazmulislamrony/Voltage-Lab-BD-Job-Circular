import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voltage_lab_bd_job_circular/screen/home_screen.dart';
import 'package:voltage_lab_bd_job_circular/screen/online_test_screen.dart';
import 'package:voltage_lab_bd_job_circular/screen/profile_screen.dart';


import 'model/categorymodel.dart';
class home_init_page extends StatefulWidget {

  // Categorymodels categorylist;
  // final Categorymodels categorylist;

  @override
  State<home_init_page> createState() => _home_init_pageState();

  // home_init_page( this.categorylist);
}

class _home_init_pageState extends State<home_init_page> {
  int _currentIndex = 1;
  final List screens = [
    profileScreen(),
    HomeScreen(),
    OnlineTestScreen(),
  ];

  // static get categorylist => Categorymodels;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 16,
        unselectedFontSize: 12,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'প্রোফাইল',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,

            ),
            label: 'হোম',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.insert_chart,
            ),
            label: 'অনলাইন টেস্ট',

          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
