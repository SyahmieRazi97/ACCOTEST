import 'dart:async';

import 'package:flutter/material.dart';

class HardLedger extends StatefulWidget {

  @override
  State<HardLedger> createState() => _HardLedgerState();
}

final ScrollController _scrollController = ScrollController();

class MapEquality {
  bool equals(Map<String, String> a, Map<String, String> b) {
    for (var key in a.keys) {
      if (a[key] != b[key] && b.containsKey(key)) return false;
    }
    return true;
  }
}

class _HardLedgerState extends State<HardLedger> {

  int countdown = 3;
  bool isCountdown = true;
  Timer? countdownTimer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Started business with RM 30,000 in bank, RM 30,000 cash and RM 20,000 furniture',
      'choices': [
        'Cash',
        'Cash 30,000',
        'Bank',
        'Bank 30,000',
        'Capital',
        'Capital 30,000',
        'Capital 30,000',
        'Capital 20,000',
        'Furniture',
        'Furniture 20,000'
      ],
      'correct': {
        'Account_1': 'Cash',
        'Acc1_Details_1': '',
        'Acc1_Details_2': 'Capital 30,000',
        'Account_2': 'Bank',
        'Acc2_Details_1': '',
        'Acc2_Details_2': 'Capital 30,000',
        'Account_3': 'Furniture',
        'Acc3_Details_1': 'Capital 20,000',
        'Acc3_Details_2': '',
        'Account_4': 'Capital',
        'Acc4_Details_1': '',
        'Acc4_Details_2': 'Cash 30,000',
        'Acc4_Details_3': '',
        'Acc4_Details_4': 'Bank 30,000',
        'Acc4_Details_5': '',
        'Acc4_Details_6': 'Furniture 20,000',


      },
    },
    {
      'question': 'Received invoice from Ketapang Enterprise RM 10,000',
      'choices': [
        'Sales',
        'Sales 10,000',
        'Purchase',
        'Purchase 10,000',
        'Acc. Receivable Ketapang Ent',
        'Acc. Receivable Ketapang Ent 10,000',
        'Acc. Payable Ketapang Ent',
        'Acc. Payable Ketapang Ent 10,000'
      ],
      'correct': {
        'Account_1': 'Purchase',
        'Acc1_Details_1': 'Acc. Payable Ketapang Ent 10,000',
        'Acc1_Details_2': '',
        'Account_2': 'Acc. Payable Ketapang Ent',
        'Acc2_Details_1': '',
        'Acc2_Details_2': 'Purchase 10,000',
        'Account_3': '',
        'Acc3_Details_1': '',
        'Acc3_Details_2': '',
        'Account_4': '',
        'Acc4_Details_1': '',
        'Acc4_Details_2': '',
      },
    },
    {
      'question': 'Sent invoice to Markisar Enterprise RM 2,000',
      'choices': [
        'Sales',
        'Sales 2,000',
        'Purchase',
        'Purchase 2,000',
        'Acc. Receivable Markisar Ent',
        'Acc. Receivable Markisar Ent 2,000',
        'Acc. Payable Markisar Ent',
        'Acc. Payable Markisar Ent 2,000'
      ],
      'correct': {
        'Account_1': 'Sales',
        'Acc1_Details_1': '',
        'Acc1_Details_2': 'Acc. Receivable Markisar Ent 2,000',
        'Account_2': 'Acc. Receivable Markisar Ent',
        'Acc2_Details_1': 'Sales 2,000',
        'Acc2_Details_2': '',
        'Account_3': '',
        'Acc3_Details_1': '',
        'Acc3_Details_2': '',
        'Account_4': '',
        'Acc4_Details_1': '',
        'Acc4_Details_2': '',
      },
    },
    {
      'question': 'Received defective goods from Markisar Enterprise RM 200',
      'choices': [
        'Sales Return',
        'Sales Return 200',
        'Purchase Return',
        'Purchase Return 200',
        'Acc. Payable Markisar Ent',
        'Acc. Payable Markisar Ent 200',
        'Acc. Receivable Markisar Ent',
        'Acc. Receivable Markisar Ent 200'
      ],
      'correct': {
        'Account_1': 'Sales Return',
        'Acc1_Details_1': 'Sales Return 200',
        'Acc1_Details_2': '',
        'Account_2': 'Acc. Receivable Markisar Ent',
        'Acc2_Details_1': '',
        'Acc2_Details_2': 'Acc. Receivable Markisar Ent 200',
        'Account_3': '',
        'Acc3_Details_1': '',
        'Acc3_Details_2': '',
        'Account_4': '',
        'Acc4_Details_1': '',
        'Acc4_Details_2': '',
      },
    },
    {
      'question': 'The business paid all outstanding amounts by cheque to Ketapang Enterprise. Received a discount of 5% discount',
      'choices': [
        'Bank',
        'Bank 9,500',
        'Discount received',
        'Discount received 500',
        'Acc. Payable Ketapang Ent',
        'Acc. Payable Ketapang Ent 9,500',
        'Acc. Payable Ketapang Ent 500'
      ],
      'correct': {
        'Account_1': 'Bank',
        'Acc1_Details_1': '',
        'Acc1_Details_2': 'Acc. Payable Ketapang Ent 9,500',
        'Account_2': 'Discount received',
        'Acc2_Details_1': '',
        'Acc2_Details_2': 'Acc. Payable Ketapang Ent 500',
        'Account_3': 'Acc. Payable Ketapang Ent',
        'Acc3_Details_1': 'Bank 9,500',
        'Acc3_Details_2': '',
        'Acc3_Details_3': 'Discount received 500',
        'Acc3_Details_4': '',
        'Account_4': '',
        'Acc4_Details_1': '',
        'Acc4_Details_2': '',
      },
    },
    {
      'question': 'Paid shop rent by cheque RM 1,700 and salary to workers RM 1,500 by cheque',
      'choices': [
        'Bank',
        'Bank 1,700',
        'Bank 1,500',
        'Salary',
        'Salary 1,500',
        'Rental',
        'Rental 1,700'
      ],
      'correct': {
        'Account_1': 'Bank',
        'Acc1_Details_1': '',
        'Acc1_Details_2': 'Salary 1,500',
        'Acc1_Details_3': '',
        'Acc1_Details_4': 'Rental 1,700',
        'Account_2': 'Salary',
        'Acc2_Details_1': 'Bank 1,500',
        'Acc2_Details_2': '',
        'Account_3': 'Rental',
        'Acc3_Details_1': 'Bank 1,700',
        'Acc3_Details_2': '',
        'Account_4': '',
        'Acc4_Details_1': '',
        'Acc4_Details_2': '',
      },
    },
  ];

  int currentQuestion = 0;
  int score = 0;
  int secondsRemaining = 70;
  Timer? timer;
  bool isSubmitted = false;

  Map<String, String> droppedSymbols = {
    'Account_1': '',
    'Acc1_Details_1': '',
    'Acc1_Details_2': '',
    'Acc1_Details_3': '',
    'Acc1_Details_4': '',
    'Account_2': '',
    'Acc2_Details_1': '',
    'Acc2_Details_2': '',
    'Account_3': '',
    'Acc3_Details_1': '',
    'Acc3_Details_2': '',
    'Acc3_Details_3': '',
    'Acc3_Details_4': '',
    'Account_4': '',
    'Acc4_Details_1': '',
    'Acc4_Details_2': '',
    'Acc4_Details_3': '',
    'Acc4_Details_4': '',
    'Acc4_Details_5': '',
    'Acc4_Details_6': '',
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
    secondsRemaining = 120;
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
      'Acc1_Details_3': '',
      'Acc1_Details_4': '',
      'Account_2': '',
      'Acc2_Details_1': '',
      'Acc2_Details_2': '',
      'Account_3': '',
      'Acc3_Details_1': '',
      'Acc3_Details_2': '',
      'Acc3_Details_3': '',
      'Acc3_Details_4': '',
      'Account_4': '',
      'Acc4_Details_1': '',
      'Acc4_Details_2': '',
      'Acc4_Details_3': '',
      'Acc4_Details_4': '',
      'Acc4_Details_5': '',
      'Acc4_Details_6': '',
    };
  }

  bool _isAnswerCorrect() {
    final correct = questions[currentQuestion]['correct'] as Map<String,
        String>;
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
          'Acc1_Details_3': '',
          'Acc1_Details_4': '',
          'Account_2': '',
          'Acc2_Details_1': '',
          'Acc2_Details_2': '',
          'Account_3': '',
          'Acc3_Details_1': '',
          'Acc3_Details_2': '',
          'Acc3_Details_3': '',
          'Acc3_Details_4': '',
          'Account_4': '',
          'Acc4_Details_1': '',
          'Acc4_Details_2': '',
          'Acc4_Details_3': '',
          'Acc4_Details_4': '',
          'Acc4_Details_5': '',
          'Acc4_Details_6': '',
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
      builder: (_) =>
          AlertDialog(
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
                      'Acc1_Details_3': '',
                      'Acc1_Details_4': '',
                      'Account_2': '',
                      'Acc2_Details_1': '',
                      'Acc2_Details_2': '',
                      'Account_3': '',
                      'Acc3_Details_1': '',
                      'Acc3_Details_2': '',
                      'Acc3_Details_3': '',
                      'Acc3_Details_4': '',
                      'Account_4': '',
                      'Acc4_Details_1': '',
                      'Acc4_Details_2': '',
                      'Acc4_Details_3': '',
                      'Acc4_Details_4': '',
                      'Acc4_Details_5': '',
                      'Acc4_Details_6': '',
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

    final correct = questions[currentQuestion]['correct'] as Map<String,
        String>;
    final user = droppedSymbols[column];

    if (user == correct[column] && user == '') {
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
    _scrollController.dispose();
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
        title: Text('Ledger Hard Quiz',
          style: TextStyle(fontFamily: 'AppleGaramond',
              fontSize: 27,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent.shade200,
      ),
      body: isCountdown
          ? Center(
        child: Text(
          'Get ready in $countdown...',
          style: TextStyle(fontSize: 32,
              fontFamily: 'AppleGaramond',
              color: Colors.pinkAccent.shade200,
              fontWeight: FontWeight.bold),
        ),
      )
          : SingleChildScrollView(
          controller: _scrollController, // Add this line
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
          style: TextStyle(fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'AppleGaramond'),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          alignment: WrapAlignment.center,
          children: (questions[currentQuestion]['choices'] as List<String>)
              .map((item) {
            return Draggable<String>(
              data: item,
              feedback: Material(
                color: Colors.transparent,
                child: Chip(label: Text(item, style: TextStyle(fontSize: 16))),
              ),
              childWhenDragging: Chip(
                label: Text(
                    item, style: TextStyle(color: Colors.pinkAccent.shade200)),
              ),
              child: Chip(
                label: Text(item,
                    style: TextStyle(
                        fontSize: 16, fontFamily: 'GlacialIndifference')),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GlacialIndifference',
                            fontSize: 16
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
                      child: Text(
                          'RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 35,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                          'RM', style: TextStyle(fontWeight: FontWeight.bold)),
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
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc1_Details_3'),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc1_Details_4'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GlacialIndifference',
                            fontSize: 16
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
                      child: Text(
                          'RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 35,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                          'RM', style: TextStyle(fontWeight: FontWeight.bold)),
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
            SizedBox(height: 20),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GlacialIndifference',
                            fontSize: 16
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
                      child: Text(
                          'RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 35,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                          'RM', style: TextStyle(fontWeight: FontWeight.bold)),
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
            SizedBox(height: 20),
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
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GlacialIndifference',
                            fontSize: 16
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade200,
                      height: 43,
                      child: dragTargetCell('Account_4'),
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
                      child: Text(
                          'RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 35,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                          'RM', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc4_Details_1'),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc4_Details_2'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc4_Details_3'),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc4_Details_4'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc4_Details_5'),
                    ),
                    Container(
                      color: Colors.pinkAccent.shade100,
                      height: 40,
                      child: dragTargetCell('Acc4_Details_6'),
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
        SizedBox(height: 10),
        if (!isSubmitted)
          ElevatedButton(
            onPressed: submitAnswer,
            child: Text('Submit'),
          ),
        if (isSubmitted) ...[
          SizedBox(height: 10),
          Text(
            _isAnswerCorrect() ? '✅ Correct!' : '❌ Some answers are wrong.',
            style: TextStyle(fontSize: 18),
          ),
          ElevatedButton(
            onPressed: nextQuestion,
            child: Text(currentQuestion < questions.length - 1
                ? 'Next Question'
                : 'Finish'),
          ),
        ],
      ],
    );
  }

  Widget dragTargetCell(String column) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        // When dragging starts, check if we need to scroll
        if (candidateData.isNotEmpty) {
          // Calculate if this target is in the bottom half of the screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final renderBox = context.findRenderObject() as RenderBox?;
            if (renderBox != null) {
              final position = renderBox.localToGlobal(Offset.zero);
              final screenHeight = MediaQuery
                  .of(context)
                  .size
                  .height;

              // If the target is in the bottom 25% of the screen, scroll down
              if (position.dy > screenHeight * 0.75) {
                _scrollController.animateTo(
                  _scrollController.offset + 100,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                );
              }
              // If the target is in the top 25% of the screen, scroll up
              else if (position.dy < screenHeight * 0.25) {
                _scrollController.animateTo(
                  _scrollController.offset - 100,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                );
              }
            }
          });
        }

        return Container(
          height: 40,
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