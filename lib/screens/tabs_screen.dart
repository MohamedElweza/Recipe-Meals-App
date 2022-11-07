import 'package:flutter/material.dart';

import 'favorites.dart';
import 'home.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pages = [
    {'page': const Home(), 'label': 'Favorites'},
    {'page': const Favorite(), 'label': 'Favorites'},
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 20,
          unselectedItemColor: Colors.black,
          selectedIconTheme: const IconThemeData(color: Color(0xff0A947D)),
          selectedItemColor: const Color(0xff0A947D),
          selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Color(0xff0A947D)),
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_filled),
            ),
            BottomNavigationBarItem(
              label: 'Favorites',
              icon: Icon(Icons.favorite_border),
            ),
          ]),
    );
  }
}
