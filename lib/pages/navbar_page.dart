import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:resto_app_1/pages/home_page.dart';
import 'package:resto_app_1/pages/settings_page.dart';

import '../theme/theme_provider.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({
    super.key,
  });

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

List newlist = [];

class _NavbarPageState extends State<NavbarPage> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: theme.getTheme() == theme.lightTheme
                ? Colors.grey.shade200
                : Colors.grey.shade800,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                activeIcon: Icon(
                  Icons.settings,
                  color: Colors.red,
                ),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped),
      ),
    );
  }
}
