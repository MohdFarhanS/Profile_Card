import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Profile App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Using default system font
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: const ProfileScreen(),
    );
  }
}