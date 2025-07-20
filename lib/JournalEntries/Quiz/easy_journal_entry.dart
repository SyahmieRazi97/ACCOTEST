import 'dart:async';

import 'package:flutter/material.dart';

class EasyJournalEntry extends StatefulWidget {

  @override
  State<EasyJournalEntry> createState() => _EasyJournalEntryState();
}

class MapEquality {
  bool equals(Map<String, String> a, Map<String, String> b) {
    for (var key in a.keys) {
      if (a[key] != b[key] && b.containsKey(key)) return false;
    }
    return true;
  }
}

class _EasyJournalEntryState extends State<EasyJournalEntry> {

  int countdown = 3;
  bool isCountdown = true;
  Timer? countdownTimer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Started business with cash at bank RM 20,000',
      'choices': ['Bank', '20,000', 'Capital', '20,000'],
      'correct': {
        'Details_1': 'Bank',
        'Details_2': 'Capital',
        'Debit_1': '20,000',
        'Debit_2': '',
        'Credit_1': '',
        'Credit_2': '20,000',
      },
    },
    {
      'question': 'Purchase goods on credit from Ben Dee Enterprise RM5,000',
      'choices': ['Purchase', '5,000', 'Acc. Payable Ben Dee Ent', '5,000'],
      'correct': {
        'Details_1': 'Purchase',
        'Details_2': 'Acc. Payable Ben Dee Ent',
        'Debit_1': '5,000',
        'Debit_2': '',
        'Credit_1': '',
        'Credit_2': '5,000',
      },
    },
    {
      'question': 'Cash sales RM 7,500',
      'choices': ['Cash', '7,500', 'Sales', '7,500'],
      'correct': {
        'Details_1': 'Cas',
        'Details_2': 'Sales',
        'Debit_1': '7,500',
        'Debit_2': '',
        'Credit_1': '',
        'Credit_2': '7,500',
      },
    },
    {
      'question': 'Paid RM 2,000 to Ben Dee Enterprise by cash',
      'choices': ['Cash', '2,000', 'Acc. Payable Ben Dee Ent', '2,000'],
      'correct': {
        'Details_1': 'Acc. Payable Ben Dee Ent',
        'Details_2': 'Cash',
        'Debit_1': '2,000',
        'Debit_2': '',
        'Credit_1': '',
        'Credit_2': '2,000',
      },
    },
    {
      'question': 'Paid rental RM 1,500 by cheque',
      'choices': ['Bank', '1,500', 'Rental', '1,500'],
      'correct': {
        'Details_1': 'Rental',
        'Details_2': 'Bank',
        'Debit_1': '1,500',
        'Debit_2': '',
        'Credit_1': '',
        'Credit_2': '1,500',
      },
    },
  ];

  int currentQuestion = 0;
  int score = 0;
  int secondsRemaining = 60;
  Timer? timer;
  bool isSubmitted = false;

  Map<String, String> droppedSymbols = {
    'Details_1': '',
    'Details_2': '',
    'Debit_1': '',
    'Debit_2': '',
    'Credit_1': '',
    'Credit_2': '',
  };

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    countdown = 3;
    isCountdown = true;
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
      });

      if (countdown == 0) {
        timer.cancel();
        isCountdown = false;
        startTimer();
      }
    });
  }

  void startTimer() {
    timer?.cancel();
    secondsRemaining = 30;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
        submitAnswer();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  void submitAnswer() {
    timer?.cancel();
    setState(() {
      isSubmitted = true;
    });

    if (_isAnswerCorrect()) {
      score += 1;
    }
  }

  void clearAnswer() {
    droppedSymbols = {
      'Details_1': '',
      'Details_2': '',
      'Debit_1': '',
      'Debit_2': '',
      'Credit_1': '',
      'Credit_2': '',
    };
  }

  bool _isAnswerCorrect() {
    final correct = questions[currentQuestion]['correct'] as Map<String, String>;
    return MapEquality().equals(droppedSymbols, correct);
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        droppedSymbols = {
          'Details_1': '',
          'Details_2': '',
          'Debit_1': '',
          'Debit_2': '',
          'Credit_1': '',
          'Credit_2': '',
        };
        isSubmitted = false;
        isCountdown = true;
      });
      startCountdown();
    } else {
      _showFinalScoreDialog();
    }
  }

  void _showFinalScoreDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Quiz Finished'),
        content: Text('Your final score is $score/${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestion = 0;
                score = 0;
                droppedSymbols = {
                  'Details_1': '',
                  'Details_2': '',
                  'Debit_1': '',
                  'Debit_2': '',
                  'Credit_1': '',
                  'Credit_2': '',
                };
                isSubmitted = false;
              });
              startTimer();
            },
            child: Text('Restart'),
          )
        ],
      ),
    );
  }

  Color getBoxColor(String column) {
    if (!isSubmitted) return Colors.grey[200]!;

    final correct = questions[currentQuestion]['correct'] as Map<String, String>;
    final user = droppedSymbols[column];

    if (user == correct[column] && user != '') {
      return Colors.green[400]!;
    } else if (user != correct[column] && user != '') {
      return Colors.red[200]!;
    } else if (user == '' && correct[column] != '') {
      return Colors.yellow[200]!;
    } else {
      return Colors.grey[400]!;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final questionText = questions[currentQuestion]['question'] as String;

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Text('Journal Entry Easy Quiz',
          style: TextStyle(fontFamily: 'AppleGaramond', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade200,
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isCountdown
            ? Center(
          child: Text(
            'Get ready in $countdown...',
            style: TextStyle(fontSize: 32, fontFamily: 'AppleGaramond', color: Colors.blueAccent.shade200, fontWeight: FontWeight.bold),
          ),
        )
            : quizUI(questionText),
      ),
    );
  }

  Widget quizUI(String questionText) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: Text('Score: $score')),
        ),
        Text(
          'Time Left: $secondsRemaining seconds',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
        SizedBox(height: 20),
        Text(
          'Transaction:\n$questionText',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'AppleGaramond'),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: (questions[currentQuestion]['choices'] as List<String>)
              .map((item) {
            return Draggable<String>(
              data: item,
              feedback: Material(
                color: Colors.transparent,
                child: Chip(label: Text(item, style: TextStyle(fontSize: 15))),
              ),
              childWhenDragging: Chip(
                label: Text(item, style: TextStyle(color: Colors.blueAccent.shade200)),
              ),
              child: Chip(
                label: Text(item,
                    style: TextStyle(fontSize: 18, fontFamily: 'GlacialIndifference')),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 30),
        Table(
          border: TableBorder.all(),
          children: [
            TableRow(children: [
              tableCell('Detail'),
              tableCell('Debit (DT)'),
              tableCell('Credit (CR)'),
            ]),
            TableRow(children: [
              dragTargetCell('Details_1'),
              dragTargetCell('Debit_1'),
              dragTargetCell('Credit_1'),
            ]),
            TableRow(children: [
              dragTargetCell('Details_2'),
              dragTargetCell('Debit_2'),
              dragTargetCell('Credit_2'),
            ]),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: clearAnswer,
          child: Text('Clear'),
        ),
        SizedBox(height: 20),
        if (!isSubmitted)
          ElevatedButton(
            onPressed: submitAnswer,
            child: Text('Submit'),
          ),
        if (isSubmitted) ...[
          SizedBox(height: 20),
          Text(
            _isAnswerCorrect() ? '✅ Correct!' : '❌ Some answers are wrong.',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: nextQuestion,
            child: Text(currentQuestion < questions.length - 1 ? 'Next Question' : 'Finish'),
          ),
        ],
      ],
    );
  }

  Widget dragTargetCell(String column) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 80,
          color: getBoxColor(column),
          child: Center(
            child: Text(
              droppedSymbols[column] ?? '',
              style: TextStyle(fontSize: 15),
            ),
          ),
        );
      },
      onAccept: (data) {
        setState(() {
          droppedSymbols[column] = data;
        });
      },
    );
  }

  Widget tableCell(String title) {
    return Container(
      height: 40,
      color: Colors.blueAccent.shade200,
      child: Center(
        child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'GlacialIndifference', fontSize: 15)),
      ),
    );
  }
}