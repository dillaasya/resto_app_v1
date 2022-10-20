import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app_1/theme/theme_provider.dart';

import 'pages/navbar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          title: 'resto app v1',
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          home: const NavbarPage(),
        ),
        
      ),
    );
  }
}

