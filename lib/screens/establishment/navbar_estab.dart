import 'package:flutter/material.dart';
import 'package:sp_mobile/screens/establishment/qr_scanner.dart';
import 'profile_estab_screen.dart';
import '../cases_screen.dart';
import '../symptoms_screen.dart';

class EstabNavbar extends StatefulWidget {
  const EstabNavbar({ Key? key }) : super(key: key);

  @override
  State<EstabNavbar> createState() => _EstabNavbarState();
}

class _EstabNavbarState extends State<EstabNavbar> {
  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    SymptomsScreen(),
    CasesScreen(),
    QRScannerScreen(),
    ProfileEstabScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      appBar: AppBar(
        title: const Text(
          "GapanTrax",
          style: TextStyle(
            color: Color(0xFF13677D)
          )
        ),
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
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: "QR SCANNER"
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