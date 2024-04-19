import 'package:flutter/material.dart';
import 'package:online_learning/auth/login_screen.dart';
import 'package:online_learning/admin/add_user_screen.dart'; // Import the AddUserScreen
import 'package:online_learning/admin/adminhome_screen.dart'; // Import the AddUserScreen

class AddUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(206, 45, 175, 219),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminhomeomeScreen()), // Navigate to AddUserScreen
              );
            },
          ),
          ListTile(
            title: Text('View Users'),
          onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserScreen()), // Navigate to AddUserScreen
              );
            },
          ),
          ListTile(
            title: Text('Edit User'),
            onTap: () {
              // Add functionality for editing user
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () async {
              // Add functionality for signing out
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
