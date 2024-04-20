import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore

class AssignmentScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to write data to Firestore
  void _submitAssignment(String title, String description) async {
    // Get the current user
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        // Add a new document with a generated ID ..await _firestore.collection('assignments').doc(user.uid).set({
        await _firestore.collection('assignments').add({
          'title': title,
          'description': description,
          'userId': user.uid,
        });
        print('Assignment submitted successfully');
      } catch (e) {
        print('Error submitting assignment: $e');
      }
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
            ElevatedButton(
              onPressed: () {
                // Example of submitting an assignment
                _submitAssignment('Assignment Title', 'Assignment Description');
              },
              child: Text('Submit Assignment'),
            ),
          ],
        ),
      ),
    );
  }
}
