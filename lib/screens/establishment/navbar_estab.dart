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

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    SymptomsScreen(),
    CasesScreen(),
    QRScannerScreen(),
    Text(
      'Index 3: Notifications',
      style: optionStyle,
    ),
    ProfileEstabScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFF00CDA6)]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
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
      ),
    );
  }
}