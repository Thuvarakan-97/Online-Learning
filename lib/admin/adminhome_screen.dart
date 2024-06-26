import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:online_learning/admin/user_screen.dart';
import 'package:online_learning/auth/auth_service.dart';
import 'package:online_learning/auth/login_screen.dart';
import 'package:online_learning/widgets/button.dart';
import 'package:online_learning/admin/learning_material.dart';

import 'package:online_learning/admin/add_assignment_screen.dart';
import 'package:online_learning/auth/auth_service.dart';
import 'package:online_learning/auth/login_screen.dart';
import 'package:online_learning/widgets/button.dart';
import 'add_user_screen.dart';



class AdminhomeomeScreen extends StatelessWidget {
  const AdminhomeomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      drawer: Drawer(
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

            ),ListTile(
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
              title: Text('Add User'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUserScreen()),
                );
              },
            ),
            ListTile(
               title: Text('Add AssignmentScreen'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAssignmentScreen()),

                );
              },
            ),
          ],
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Admin",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: "Sign Out",
              onPressed: () async {
                await auth.signout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
