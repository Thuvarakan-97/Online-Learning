import 'package:flutter/material.dart';
import 'package:online_learning/auth/auth_service.dart';
import 'package:online_learning/auth/login_screen.dart';
import 'package:online_learning/widgets/button.dart';

class AdminhomeomeScreen extends StatelessWidget {
  const AdminhomeomeScreen({Key? key});

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
            ),
            ListTile(
              title: Text('Add User'),
              onTap: () {
                // Add functionality for adding user
              },
            ),
            ListTile(
              title: Text('View Users'),
              onTap: () {
                // Add functionality for viewing users
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
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome User",
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
