import 'dart:async';

import 'package:flutter/material.dart';

class MediumJournalEntry extends StatefulWidget {

  @override
  State<MediumJournalEntry> createState() => _MediumJournalEntryState();
}

class MapEquality {
  bool equals(Map<String, String> a, Map<String, String> b) {
    for (var key in a.keys) {
      if (a[key] != b[key] && b.containsKey(key)) return false;
    }
    return true;
  }
}

class _MediumJournalEntryState extends State<MediumJournalEntry> {

  int countdown = 3;
  bool isCountdown = true;
  Timer? countdownTimer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Started business with cash in hand RM 20,000 and brought in vehicle RM 70,000 into the business',
      'choices': ['Cash', '20,000', 'Capital', '90,000', 'Vehicle', '70,000'],
      'correct': {
        'Details_1': 'Cash',
        'Details_2': 'Vehicle',
        'Details_3': 'Capital',
        'Debit_1': '20,000',
        'Debit_2': '70,000',
        'Debit_3': '',
        'Credit_1': '',
        'Credit_2': '',
        'Credit_3': '90,000',
      },
    },
    {
      'question': 'Bought goods RM 10,000 on credit from Melhor Enterprise and received 10% trade discount',
      'choices': ['Purchase', '9,000', 'Acc. Payable Melhor Ent', '9,000'],
      'correct': {
        'Details_1': 'Purchase',
        'Details_2': 'Acc. Payable Melhor Ent',
        'Details_3': '',
        'Debit_1': '9,000',
        'Debit_2': '',
        'Debit_3': '',
        'Credit_1': '',
        'Credit_2': '9,000',
        'Credit_3': '',
      },
    },
    {
      'question': 'Sold goods on credit to Haura Enterprise RM 6,000',
      'choices': ['Acc. Receivable Haura Ent', '6,000', 'Sales', '6,000'],
      'correct': {
        'Details_1': 'Acc. Receivable Haura Ent',
        'Details_2': 'Sales',
        'Details_3': '',
        'Debit_1': '6,000',
        'Debit_2': '',
        'Debit_3': '',
        'Credit_1': '',
        'Credit_2': '6,000',
        'Credit_3': '',
      },
    },
    {
      'question': 'Returned damaged goods to Melhor Enterprise RM 200',
      'choices': ['Return Purchase', '200', 'Acc. Payable Melhor Ent', '200'],
      'correct': {
        'Details_1': 'Acc. Payable Melhor Ent',
        'Details_2': 'Return Purchase',
        'Details_3': '',
        'Debit_1': '200',
        'Debit_2': '',
        'Debit_3': '',
        'Credit_1': '',
        'Credit_2': '200',
        'Credit_3': '',
      },
    },
    {
      'question': 'Mr Kan Tan took cash to pay for her personal expenses RM800',
      'choices': ['Cash', '800', 'Drawings', '800'],
      'correct': {
        'Details_1': 'Drawings',
        'Details_2': 'Cash',
        'Details_3': '',
        'Debit_1': '800',
        'Debit_2': '',
        'Debit_3': '',
        'Credit_1': '',
        'Credit_2': '800',
        'Credit_3': '',
      },
    },
  ];

  int currentQuestion = 0;
  int score = 0;
  int secondsRemaining = 30;
  Timer? timer;
  bool isSubmitted = false;

  Map<String, String> droppedSymbols = {
    'Details_1': '',
    'Details_2': '',
    'Details_3': '',
    'Debit_1': '',
    'Debit_2': '',
    'Debit_3': '',
    'Credit_1': '',
    'Credit_2': '',
    'Credit_3': '',
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
    secondsRemaining = 60;
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
      'Details_3': '',
      'Debit_1': '',
      'Debit_2': '',
      'Debit_3': '',
      'Credit_1': '',
      'Credit_2': '',
      'Credit_3': '',
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
          'Details_3': '',
          'Debit_1': '',
          'Debit_2': '',
          'Debit_3': '',
          'Credit_1': '',
          'Credit_2': '',
          'Credit_3': '',
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
                  'Details_3': '',
                  'Debit_1': '',
                  'Debit_2': '',
                  'Debit_3': '',
                  'Credit_1': '',
                  'Credit_2': '',
                  'Credit_3': '',
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
        title: Text('Journal Entry Medium Quiz',
          style: TextStyle(fontFamily: 'AppleGaramond', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade200,
      ),
      body: isCountdown
          ? Center(
        child: Text(
          'Get ready in $countdown...',
          style: TextStyle(fontSize: 32, fontFamily: 'AppleGaramond', color: Colors.blueAccent.shade200, fontWeight: FontWeight.bold),
        ),
      )
          : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: quizUI(questionText)
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
            TableRow(children: [
              dragTargetCell('Details_3'),
              dragTargetCell('Debit_3'),
              dragTargetCell('Credit_3'),
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