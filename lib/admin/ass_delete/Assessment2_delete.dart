import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class assessment2_delete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Question_delete',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('questions2').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<QueryDocumentSnapshot> questions = snapshot.data!.docs;
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> questionData =
                  questions[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(questionData['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    questionData['options'].length,
                    (optionIndex) => Text(
                      questionData['options'][optionIndex],
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await _firestore
                        .collection('questions')
                        .doc(questions[index].id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
