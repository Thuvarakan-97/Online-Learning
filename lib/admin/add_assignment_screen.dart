import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_learning/auth/login_screen.dart';
import 'package:online_learning/admin/add_user_screen.dart'; 
import 'package:online_learning/admin/adminhome_screen.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAssignmentScreen extends StatefulWidget {
    final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final TextEditingController _titleController = TextEditingController();
  // final TextEditingController _descriptionController = TextEditingController();
  @override
  _AddAssignmentScreenState createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _correctAnswerIndex = -1;
  final List<TextEditingController> _optionsControllers = List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Assignment'),
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
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminhomeomeScreen()),
                );
              },
            ),
            ListTile(
              title: Text('View Users'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Assignment Title'),
                validator: (value) {
                  // if (value.isEmpty) {
                  //   return 'Please enter a title';
                  // }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Assignment Description'),
                validator: (value) {
                  // if (value.isEmpty) {
                  //   return 'Please enter a description';
                  // }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Options:'),
              ...List.generate(4, (index) {
                return Row(
                  children: [
                    Radio(
                      value: index,
                      groupValue: _correctAnswerIndex,
                      onChanged: (value) {
                        setState(() {
                          _correctAnswerIndex = value as int;
                        });
                      },
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _optionsControllers[index],
                        decoration: InputDecoration(labelText: 'Option ${index + 1}'),
                        validator: (value) {
                          // if (value?.isEmpty) {
                          //   return 'Please enter an option';
                          // }
                          return null;
                        },
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitAssignment();
                  }
                },
                child: Text('Submit Assignment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitAssignment() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final options = _optionsControllers.map((controller) => controller.text).toList();
    final correctAnswer = options[_correctAnswerIndex];
    FirebaseFirestore.instance.collection('assignment').add({
      'title': title,
      'description': description,
      'options': options,
      'correctAnswer': correctAnswer,
    }).then((value) {
      _titleController.clear();
      _descriptionController.clear();
      _optionsControllers.forEach((controller) => controller.clear());
      setState(() {
        _correctAnswerIndex = -1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Assignment submitted successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit assignment: $error')),
      );
    });
  }
}
