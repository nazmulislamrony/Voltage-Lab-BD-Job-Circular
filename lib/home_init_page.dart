import 'package:flutter/material.dart';
import 'package:voltage_lab_bd_job_circular/Page/Home.dart';
import 'package:voltage_lab_bd_job_circular/Page/online_test.dart';
import 'package:voltage_lab_bd_job_circular/Page/profile.dart';
class home_init_page extends StatefulWidget {
  const home_init_page({Key? key}) : super(key: key);

  @override
  State<home_init_page> createState() => _home_init_pageState();
}

class _home_init_pageState extends State<home_init_page> {
  int _currentIndex = 1;
  final List screens = [

    profile(),
    Home(),
    online_test(),
  ];
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
