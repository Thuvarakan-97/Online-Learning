import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class game1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Image Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddQuestionPage(),
    );
  }
}

class AddQuestionPage extends StatefulWidget {
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionController = TextEditingController();
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<String?> _uploadImageToStorage() async {
    if (_imageFile == null) return null;

    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');

    UploadTask uploadTask = storageReference.putFile(_imageFile!);

    TaskSnapshot snapshot = await uploadTask;

    return await snapshot.ref.getDownloadURL();
  }

  Future<void> _addQuestionToFirestore(String imageUrl) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('questions').add({
      'question': _questionController.text,
      'imageUrl': imageUrl,
      'correctOption': _optionController.text,
    });

    // Clear the text fields and image file after adding the question
    _questionController.clear();
    _optionController.clear();
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Enter Question'),
            ),
            SizedBox(height: 16.0),
            _imageFile != null
                ? Image.file(_imageFile!)
                : Placeholder(
                    fallbackHeight: 200.0,
                  ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Choose Image'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _optionController,
              decoration: InputDecoration(labelText: 'Enter Correct Option'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String? imageUrl = await _uploadImageToStorage();
                if (imageUrl != null) {
                  await _addQuestionToFirestore(imageUrl);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Question added successfully!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to upload image!'),
                  ));
                }
              },
              child: Text('Add Question'),
            ),
          ],
        ),
      ),
    );
  }
}
