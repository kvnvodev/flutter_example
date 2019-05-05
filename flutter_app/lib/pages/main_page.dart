import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/account_page.dart';

class SPMainPage extends StatefulWidget {
  @override
  _SPMainPageState createState() => _SPMainPageState();
}

class _SPMainPageState extends State<SPMainPage> {
  int _selectedIndex;
  List<Widget> _subPages;

  @override
  void initState() {
    super.initState();

    _selectedIndex = 0;
    _subPages = [SPHomePage(), SPAccountPage()];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _subPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(Icons.spa),
              activeIcon: Icon(Icons.spa)),
          BottomNavigationBarItem(
              title: Text("Account"),
              icon: Icon(Icons.cake),
              activeIcon: Icon(Icons.cake))
        ],
        onTap: (int selectedIndex) {
          print("__DEBUG__ selectedIndex: $selectedIndex");
          setState(() {
            _selectedIndex = selectedIndex;
          });
        },
        currentIndex: _selectedIndex,
      ),
    );
  }
}
