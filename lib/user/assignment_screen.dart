import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _submitAssignment() async {
    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      print('Please enter both title and description');
      return;
    }

    final User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('assignments').add({
          'title': title,
          'description': description,
          'userId': user.uid,
        });
        print('Assignment submitted successfully');
      } catch (e) {
        print('Error submitting assignment: $e');
        // You can show an error dialog or snackbar to the user
      }
    } else {
      print('User not signed in');
      // You can redirect user to sign in screen or show a message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Assignments!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Here you can view and submit your assignments.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Assignment Title',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Assignment Description',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAssignment,
              child: Text('Submit Assignment'),
            ),
          ],
        ),
      ),
    );
  }
}
