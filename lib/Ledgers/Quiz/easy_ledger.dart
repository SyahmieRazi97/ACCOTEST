import 'dart:async';

import 'package:flutter/material.dart';

class EasyLedger extends StatefulWidget {

  @override
  State<EasyLedger> createState() => _EasyLedgerState();
}

class MapEquality {
  bool equals(Map<String, String> a, Map<String, String> b) {
    for (var key in a.keys) {
      if (a[key] != b[key] && b.containsKey(key)) return false;
    }
    return true;
  }
}

class _EasyLedgerState extends State<EasyLedger> {

  int countdown = 3;
  bool isCountdown = true;
  Timer? countdownTimer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Started business with cash at bank RM 20,000',
      'choices': ['Bank', 'Bank 20,000', 'Capital', 'Capital 20,000'],
      'correct': {
        'Account_1': 'Bank',
        'Acc1_Details_1': 'Capital 20,000',
        'Acc1_Details_2': '',
        'Account_2': 'Capital',
        'Acc2_Details_1': '',
        'Acc2_Details_2': 'Bank 20,000',
      },
    },
    {
      'question': 'Purchase goods on credit from Ben Dee Enterprise RM5,000',
      'choices': ['Purchase', 'Purchase 5,000', 'Acc. Payable Ben Dee Ent', 'Acc. Payable Ben Dee Ent 5,000'],
      'correct': {
        'Account_1': 'Purchase',
        'Acc1_Details_1': 'Acc. Payable Ben Dee Ent 5,000',
        'Acc1_Details_2': '',
        'Account_2': 'Acc. Payable Ben Dee Ent',
        'Acc2_Details_1': '',
        'Acc2_Details_2': 'Purchase 5,000',
      },
    },
    {
      'question': 'Cash sales RM 7,500',
      'choices': ['Cash', 'Cash 7,500', 'Sales', 'Sales 7,500'],
      'correct': {
        'Account_1': 'Cash',
        'Acc1_Details_1': 'Sales 7,500',
        'Acc1_Details_2': '',
        'Account_2': 'Sales',
        'Acc2_Details_1': '',
        'Acc2_Details_2': 'Cash 7,500',
      },
    },
    {
      'question': 'Paid RM 2,000 to Ben Dee Enterprise by cash',
      'choices': ['Cash', 'Cash 2,000', 'Acc. Payable Ben Dee Ent', 'Acc. Payable Ben Dee Ent 2,000'],
      'correct': {
        'Account_1': 'Cash',
        'Acc1_Details_1': '',
        'Acc1_Details_2': 'Acc. Payable Ben Dee Ent 2,000',
        'Account_2': 'Acc. Payable Ben Dee Ent',
        'Acc2_Details_1': 'Cash 2,000',
        'Acc2_Details_2': '',
      },
    },
    {
      'question': 'Paid rental RM 1,500 by cheque',
      'choices': ['Bank', 'Bank 1,500', 'Rental', 'Rental 1,500'],
      'correct': {
        'Account_1': 'Bank',
        'Acc1_Details_1': '',
        'Acc1_Details_2': 'Rental 1,500',
        'Account_2': 'Rental',
        'Acc2_Details_1': 'Bank 1,500',
        'Acc2_Details_2': '',
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
      'Account_1': '',
      'Acc1_Details_1': '',
      'Acc1_Details_2': '',
      'Account_2': '',
      'Acc2_Details_1': '',
      'Acc2_Details_2': '',
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
        title: Text('Ledger Easy Quiz',
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time Left: $secondsRemaining seconds',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
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
                      alignment: Alignment.centerRight,
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
                      alignment: Alignment.centerLeft,
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
                      alignment: Alignment.centerRight,
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
