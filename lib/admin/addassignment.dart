import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to write data to Firestore
  void _submitAssignment(
    String question,
    String option1,
    String option2,
    String option3,
    String option4,
    int correctOption,
  ) async {
    // Get the current user
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        // Add a new document with user's UID as document ID
        await _firestore.collection('assignments').doc(user.uid).set({
          'question': question,
          'option1': option1,
          'option2': option2,
          'option3': option3,
          'option4': option4,
          'correct_option': correctOption,
          'userId': user.uid,
        });
        print('Assignment submitted successfully');
      } catch (e) {
        print('Error submitting assignment: $e');
      }
    }
  }

// Function to retrieve assignments from Firestore
  Future<List<Map<String, dynamic>>> _getAssignments() async {
    User? user = _auth.currentUser;
    List<Map<String, dynamic>> assignments = [];
    if (user != null) {
      try {
        QuerySnapshot querySnapshot = await _firestore
            .collection('assignments')
            .where('userId', isEqualTo: user.uid)
            .get();
        querySnapshot.docs.forEach((doc) {
          assignments.add(doc.data() as Map<String, dynamic>);
        });
      } catch (e) {
        print('Error retrieving assignments: $e');
      }
    }
    return assignments;
  }

  @override
  Widget build(BuildContext context) {
    String question = '';
    String option1 = '';
    String option2 = '';
    String option3 = '';
    String option4 = '';
    int correctOption = 1;

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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Submit Assignment'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              onChanged: (value) {
                                question = value;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Question'),
                            ),
                            TextField(
                              onChanged: (value) {
                                option1 = value;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Option 1'),
                            ),
                            TextField(
                              onChanged: (value) {
                                option2 = value;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Option 2'),
                            ),
                            TextField(
                              onChanged: (value) {
                                option3 = value;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Option 3'),
                            ),
                            TextField(
                              onChanged: (value) {
                                option4 = value;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Option 4'),
                            ),
                            TextField(
                              onChanged: (value) {
                                correctOption = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Correct Option (1-4)'),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            _submitAssignment(
                              question,
                              option1,
                              option2,
                              option3,
                              option4,
                              correctOption,
                            );
                            Navigator.pop(context);
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Submit Assignment'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                List<Map<String, dynamic>> assignments =
                    await _getAssignments();
                // Show assignments in a dialog or navigate to a new screen
                // Example:
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Your Assignments'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: assignments.map((assignment) {
                            return ListTile(
                              title: Text(assignment['question']),
                              subtitle: Text(
                                  'Correct Option: ${assignment['correct_option']}'),
                            );
                          }).toList(),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('View Assignments'),
            ),
          ],
        ),
      ),
    );
  }
}
