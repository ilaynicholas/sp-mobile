// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:sp_mobile/screens/user/notifications_screen.dart';
import 'package:sp_mobile/screens/user/status_widget.dart';
import '../cases_screen.dart';
import 'profile_screen.dart';
import 'qr_code_screen.dart';
import '../symptoms_screen.dart';

class UserNavbar extends StatefulWidget {
  const UserNavbar({ Key? key }) : super(key: key);

  @override
  State<UserNavbar> createState() => _UserNavbarState();
}

class _UserNavbarState extends State<UserNavbar> {
  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    SymptomsScreen(),
    CasesScreen(),
    QRCodeScreen(),
    NotificationsScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final el = window.document.getElementById('__ff-recaptcha-container');
    if(el != null) {
      el.style.visibility = 'hidden';
    }
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const StatusWidget(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.coronavirus_outlined),
            label: "SYMPTOMS"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: "CASES"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_outlined),
            label: "QR CODE"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: "NOTIFICATIONS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: "PROFILE"
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF13677D),
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onItemTapped
      )
    );
  }
}