import 'package:flutter/material.dart';
import 'package:online_learning/auth/login_screen.dart';

import 'package:online_learning/admin/add_user_screen.dart';
void main() {
  runApp(const SideMenu());
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      initialRoute: '/', // Initial route, if needed
      routes: {
        '/': (context) => const LoginScreen(), // Example: LoginScreen as home
        '/add_user': (context) => AddUserScreen(),
       // '/view_users': (context) => ViewUsersScreen(),
      //  '/edit_user': (context) => EditUserScreen(),
        // Add more routes as needed
      },
    );
  }
}
