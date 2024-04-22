
import 'package:online_learning/auth/auth_service.dart';
import 'package:online_learning/auth/login_screen.dart';
import 'package:online_learning/widgets/button.dart';
import 'package:flutter/material.dart';

import 'package:online_learning/user/learning_material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),

import 'package:flutter/material.dart';
import 'package:online_learning/auth/auth_service.dart';
import 'package:online_learning/auth/login_screen.dart';
import 'package:online_learning/user/assignment_screen.dart';
import 'package:online_learning/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(

                color: Color.fromARGB(255, 22, 139, 234),

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

              title: Text('learning material'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LearningMaterialPage()), // Navigate to AssignmentScreen
                );
              },
            ),
            ListTile(
              title: Text('report'),
              onTap: () {},

              title: Text('Item 1'),
              onTap: () async {
                   await auth.signout();
                goToLogin(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle item 2 press
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () async {
                await auth.signout();
                goToLogin(context);
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

              label: "Do Something",
              onPressed: () {
                // Add your button functionality here
              },
            )
          ],
        ),
      ),
    );
  }

  goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
  goToView(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AssignmentScreen()),
    );
  }

}
