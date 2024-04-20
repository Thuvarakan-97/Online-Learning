import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class assessmentScreen extends StatefulWidget {
  @override
  _assessmentScreenState createState() => _assessmentScreenState();
}

class _assessmentScreenState extends State<assessmentScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _questions = [];
  int _correctAnswersCount = 0;
  late List<int?> _selectedOptions;

  _assessmentScreenState() {
    _selectedOptions = [];
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  void _fetchQuestions() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('questions').get();
    setState(() {
      _questions = querySnapshot.docs.map((doc) => doc.data()).toList();
      _selectedOptions = List.generate(_questions.length, (_) => null);
    });
  }

  void _submitAnswer(int questionIndex, int optionIndex, String correctOption,
      BuildContext context) {
    if (_selectedOptions[questionIndex] != null)
      return; // Answer already selected
    setState(() {
      _selectedOptions[questionIndex] = optionIndex;
    });
    if (optionIndex ==
        _questions[questionIndex]['options'].indexOf(correctOption)) {
      setState(() {
        _correctAnswersCount++;
      });
      // Show correct feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correct!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Show incorrect feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('assessment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Questions',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, questionIndex) {
                  Map<String, dynamic> question = _questions[questionIndex];
                  List<dynamic> options = question['options'];
                  String correctOption = question['correctOption'];
                  return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            question['question'],
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          ...List.generate(
                            options.length,
                            (optionIndex) {
                              String option = options[optionIndex];
                              bool isCorrect = option == correctOption;
                              return ElevatedButton(
                                onPressed: () {
                                  _submitAnswer(questionIndex, optionIndex,
                                      correctOption, context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      _selectedOptions[questionIndex] != null &&
                                              optionIndex ==
                                                  _selectedOptions[
                                                      questionIndex]
                                          ? (isCorrect
                                              ? MaterialStateProperty.all(
                                                  Colors.green)
                                              : MaterialStateProperty.all(
                                                  Colors.red))
                                          : null,
                                ),
                                child: Text(option),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Correct Answers: $_correctAnswersCount',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
