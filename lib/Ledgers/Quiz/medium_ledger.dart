import 'dart:async';

import 'package:flutter/material.dart';

class MediumLedger extends StatefulWidget {

  @override
  State<MediumLedger> createState() => _MediumLedgerState();
}

class MapEquality {
  bool equals(Map<String, String> a, Map<String, String> b) {
    for (var key in a.keys) {
      if (a[key] != b[key] && b.containsKey(key)) return false;
    }
    return true;
  }
}

class _MediumLedgerState extends State<MediumLedger> {

  int countdown = 3;
  bool isCountdown = true;
  Timer? countdownTimer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Started business with cash in hand RM 20,000 and brought in vehicle RM 70,000 into the business',
      'choices': ['Cash', 'Cash 20,000', 'Capital', 'Capital 70,000', 'Capital 20,000', 'Vehicle', 'Vehicle 70,000'],
      'correct': {
        'Account_1': 'Cash',
        'Acc1_Details_1': 'Capital 20,000',
        'Acc1_Details_2': '',
        'Account_2': 'Vehicle',
        'Acc2_Details_1': 'Capital 70,000',
        'Acc2_Details_2': '',
        'Account_3': 'Capital',
        'Acc3_Details_1': '',
        'Acc3_Details_2': 'Cash 20,000',
        'Acc3_Details_3': '',
        'Acc3_Details_4': 'Vehicle 70,000',
      },
    },
    {
      'question': 'Bought goods RM 10,000 on credit from Melhor Enterprise and received 10% trade discount',
      'choices': ['Purchase', 'Purchase 9,000', 'Acc. Payable Melhor Ent', 'Acc. Payable Melhor Ent 9,000'],
      'correct': {
        'Account_1': 'Purchase',
        'Acc1_Details_1': 'Acc. Payable Melhor Ent 9,000',
        'Acc1_Details_2': '',
        'Account_2': 'Acc. Payable Melhor Ent',
        'Acc2_Details_1': '',
        'Acc2_Details_2': 'Purchase 9,000',
        'Account_3': '',
        'Acc3_Details_1': '',
        'Acc3_Details_2': '',
      },
    },
    {
      'question': 'Sold goods on credit to Haura Enterprise RM 6,000',
      'choices': ['Acc. Receivable Haura Ent', 'Acc. Receivable Haura Ent 6,000', 'Sales', 'Sales 6,000'],
      'correct': {
        'Account_1': 'Acc. Receivable Haura Ent',
        'Acc1_Details_1': 'Sales 6,000',
        'Acc1_Details_2': '',
        'Account_2': 'Sales',
        'Acc2_Details_1': '',
        'Acc2_Details_2': 'Acc. Receivable Haura Ent 6,000',
        'Account_3': '',
        'Acc3_Details_1': '',
        'Acc3_Details_2': '',
      },
    },
    {
      'question': 'Returned damaged goods to Melhor Enterprise RM 200',
      'choices': ['Return Purchase', 'Return Purchase 200', 'Acc. Payable Melhor Ent', 'Acc. Payable Melhor Ent 200'],
      'correct': {
        'Account_1': 'Return Purchase',
        'Acc1_Details_1': '',
        'Acc1_Details_2': 'Acc. Payable Melhor Ent 200',
        'Account_2': 'Acc. Payable Melhor Ent',
        'Acc2_Details_1': 'Return Purchase 200',
        'Acc2_Details_2': '',
        'Account_3': '',
        'Acc3_Details_1': '',
        'Acc3_Details_2': '',
      },
    },
    {
      'question': 'Mr Kan Tan took cash to pay for her personal expenses RM800',
      'choices': ['Cash', 'Cash 800', 'Drawings', 'Drawings 800'],
      'correct': {
        'Account_1': 'Cash',
        'Acc1_Details_1': '',
        'Acc1_Details_2': 'Drawings 800',
        'Account_2': 'Drawings',
        'Acc2_Details_1': 'Cash 800',
        'Acc2_Details_2': '',
        'Account_3': '',
        'Acc3_Details_1': '',
        'Acc3_Details_2': '',
      },
    },
  ];

  int currentQuestion = 0;
  int score = 0;
  int secondsRemaining = 30;
  Timer? timer;
  bool isSubmitted = false;

  Map<String, String> droppedSymbols = {
    'Account_1': '',
    'Acc1_Details_1': '',
    'Acc1_Details_2': '',
    'Account_2': '',
    'Acc2_Details_1': '',
    'Acc2_Details_2': '',
    'Account_3': '',
    'Acc3_Details_1': '',
    'Acc3_Details_2': '',
    'Acc3_Details_3': '',
    'Acc3_Details_4': '',
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
      'Account_1': '',
      'Acc1_Details_1': '',
      'Acc1_Details_2': '',
      'Account_2': '',
      'Acc2_Details_1': '',
      'Acc2_Details_2': '',
      'Account_3': '',
      'Acc3_Details_1': '',
      'Acc3_Details_2': '',
      'Acc3_Details_3': '',
      'Acc3_Details_4': '',
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
          'Account_1': '',
          'Acc1_Details_1': '',
          'Acc1_Details_2': '',
          'Account_2': '',
          'Acc2_Details_1': '',
          'Acc2_Details_2': '',
          'Account_3': '',
          'Acc3_Details_1': '',
          'Acc3_Details_2': '',
          'Acc3_Details_3': '',
          'Acc3_Details_4': '',
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
                  'Account_1': '',
                  'Acc1_Details_1': '',
                  'Acc1_Details_2': '',
                  'Account_2': '',
                  'Acc2_Details_1': '',
                  'Acc2_Details_2': '',
                  'Account_3': '',
                  'Acc3_Details_1': '',
                  'Acc3_Details_2': '',
                  'Acc3_Details_3': '',
                  'Acc3_Details_4': '',
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
        title: Text('Ledger Medium Quiz',
          style: TextStyle(fontFamily: 'AppleGaramond', fontSize: 27, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent.shade200,
      ),
      body: isCountdown
          ? Center(
        child: Text(
          'Get ready in $countdown...',
          style: TextStyle(fontSize: 32, fontFamily: 'AppleGaramond', color: Colors.pinkAccent.shade200, fontWeight: FontWeight.bold),
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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'AppleGaramond'),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          alignment: WrapAlignment.start,
          children: (questions[currentQuestion]['choices'] as List<String>)
              .map((item) {
            return Draggable<String>(
              data: item,
              feedback: Material(
                color: Colors.transparent,
                child: Chip(label: Text(item, style: TextStyle(fontSize: 15))),
              ),
              childWhenDragging: Chip(
                label: Text(item, style: TextStyle(color: Colors.pinkAccent.shade200)),
              ),
              child: Chip(
                label: Text(item,
                    style: TextStyle(fontSize: 18, fontFamily: 'GlacialIndifference')),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Table(
              border: TableBorder.all(color: Colors.white, width: 1),
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade200,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Account:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'GlacialIndifference', fontSize: 16
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade200,
                      height: 43,
                      child: dragTargetCell('Account_1'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 35,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: Text('RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 35,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: Text('RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc1_Details_1'),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc1_Details_2'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24), // spacing between tables
            Table(
              border: TableBorder.all(color: Colors.white, width: 1),
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade200,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Account:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'GlacialIndifference', fontSize: 16
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade200,
                      height: 43,
                      child: dragTargetCell('Account_2'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 35,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: Text('RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 35,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: Text('RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc2_Details_1'),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc2_Details_2'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24), // spacing between tables
            Table(
              border: TableBorder.all(color: Colors.white, width: 1),
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade200,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Account:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'GlacialIndifference', fontSize: 16
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade200,
                      height: 43,
                      child: dragTargetCell('Account_3'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 35,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: Text('RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 35,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: Text('RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc3_Details_1'),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc3_Details_2'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc3_Details_3'),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc3_Details_4'),
                    ),
                  ],
                ),
              ],
            ),
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
}
