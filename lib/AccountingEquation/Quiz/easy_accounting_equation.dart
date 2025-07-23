import 'dart:async';
import 'package:flutter/material.dart';

class EasyAccountingEquation extends StatefulWidget {

  @override
  State<EasyAccountingEquation> createState() => _EasyAccountingEquationState();
}

class MapEquality {
  bool equals(Map<String, String> a, Map<String, String> b) {
    for (var key in a.keys) {
      if (a[key] != b[key] && b.containsKey(key)) return false;
    }
    return true;
  }
}

class _EasyAccountingEquationState extends State<EasyAccountingEquation> {

  int countdown = 3;
  bool isCountdown = true;
  Timer? countdownTimer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Started business with cash at bank RM 20,000',
      'choices': ['Bank +20,000', 'Bank -20,000', 'Capital +20,000', 'Capital -20,000'],
      'correct': {
        'Assets_1': 'Bank +20,000',
        'Assets_2': '',
        '+_1':'',
        '+_4':'',
        'Expenses_1': '',
        'Expenses_2': '',
        '=':'',
        'Liabilities_1': '',
        'Liabilities_2': '',
        '+_2':'',
        '+_5':'',
        'Equity_1': 'Capital +20,000',
        'Equity_2': '',
        '+_3':'',
        '+_6':'',
        'Revenues_1': '',
        'Revenues_2': '',
      },
    },
    {
      'question': 'Purchased goods on credit from Ben Dee Enterprise RM 5,000',
      'choices': ['Purchase +5,000', 'Acc. Payable +5,000'],
      'correct': {
        'Assets_1': '',
        'Assets_2': '',
        '+_1':'',
        '+_4':'',
        'Expenses_1': 'Purchase +5,000',
        'Expenses_2': '',
        '=':'',
        'Liabilities_1': 'Acc. Payable +5,000',
        'Liabilities_2': '',
        '+_2':'',
        '+_5':'',
        'Equity_1': '',
        'Equity_2': '',
        '+_3':'',
        '+_6':'',
        'Revenues_1': '',
        'Revenues_2': '',
      },
    },
    {
      'question': 'Cash sales RM 7,500',
      'choices': ['Cash +7,500', 'Sales +7,500', 'Cash -7,500', 'Sales -7,500'],
      'correct': {
        'Assets_1': 'Cash +7,500',
        'Assets_2': '',
        '+_1':'',
        '+_4':'',
        'Expenses_1': '',
        'Expenses_2': '',
        '=':'',
        'Liabilities_1': '',
        'Liabilities_2': '',
        '+_2':'',
        '+_5':'',
        'Equity_1': '',
        'Equity_2': '',
        '+_3':'',
        '+_6':'',
        'Revenues_1': 'Sales +7,500',
        'Revenues_2': '',
      },
    },
    {
      'question': 'Paid RM 2,000 to Ben Dee Enterprise by cash',
      'choices': ['Cash +2,000', 'Acc. Payable +2,000', 'Cash -2,000', 'Acc. Payable -2,000'],
      'correct': {
        'Assets_1': 'Cash -2,000',
        'Assets_2': '',
        '+_1':'',
        '+_4':'',
        'Expenses_1': '',
        'Expenses_2': '',
        '=':'',
        'Liabilities_1': 'Acc. Payable -2,000',
        'Liabilities_2': '',
        '+_2':'',
        '+_5':'',
        'Equity_1': '',
        'Equity_2': '',
        '+_3':'',
        '+_6':'',
        'Revenues_1': '',
        'Revenues_2': '',
      },
    },
    {
      'question': 'Paid rental RM 1,500 by cheque',
      'choices': ['Bank -1,500', 'Rental +1,500'],
      'correct': {
        'Assets_1': 'Bank -1,500',
        'Assets_2': '',
        '+_1':'',
        '+_4':'',
        'Expenses_1': 'Rental +1,500',
        'Expenses_2': '',
        '=':'',
        'Liabilities_1': '',
        'Liabilities_2': '',
        '+_2':'',
        '+_5':'',
        'Equity_1': '',
        'Equity_2': '',
        '+_3':'',
        '+_6':'',
        'Revenues_1': '',
        'Revenues_2': '',
      },
    },
  ];

  int currentQuestion = 0;
  int score = 0;
  int secondsRemaining = 30;
  Timer? timer;
  bool isSubmitted = false;

  Map<String, String> droppedSymbols = {
    'Assets_1': '',
    'Assets_2': '',
    '+_1': '',
    '+_4': '',
    'Expenses_1': '',
    'Expenses_2': '',
    '=': '',
    'Liabilities_1': '',
    'Liabilities_2': '',
    '+_2': '',
    '+_5': '',
    'Equity_1': '',
    'Equity_2': '',
    '+_3': '',
    '+_6': '',
    'Revenues_1': '',
    'Revenues_2': '',
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
      'Assets_1': '',
      'Assets_2': '',
      '+_1':'',
      '+_4':'',
      'Expenses_1': '',
      'Expenses_2': '',
      '=':'',
      'Liabilities_1': '',
      'Liabilities_2': '',
      '+_2':'',
      '+_5':'',
      'Equity_1': '',
      'Equity_2': '',
      '+_3':'',
      '+_6':'',
      'Revenues_1': '',
      'Revenues_2': '',
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
          'Assets_1': '',
          'Assets_2': '',
          '+_1':'',
          '+_4':'',
          'Expenses_1': '',
          'Expenses_2': '',
          '=':'',
          'Liabilities_1': '',
          'Liabilities_2': '',
          '+_2':'',
          '+_5':'',
          'Equity_1': '',
          'Equity_2': '',
          '+_3':'',
          '+_6':'',
          'Revenues_1': '',
          'Revenues_2': '',
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
                  'Assets_1': '',
                  'Assets_2': '',
                  '+_1':'',
                  '+_4':'',
                  'Expenses_1': '',
                  'Expenses_2': '',
                  '=':'',
                  'Liabilities_1': '',
                  'Liabilities_2': '',
                  '+_2':'',
                  '+_5':'',
                  'Equity_1': '',
                  'Equity_2': '',
                  '+_3':'',
                  '+_6':'',
                  'Revenues_1': '',
                  'Revenues_2': '',
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
        title: Text('Accounting Equation Easy Quiz',
          style: TextStyle(fontFamily: 'AppleGaramond', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade400,
      ),
      body: isCountdown
          ? Center(
        child: Text(
          'Get ready in $countdown...',
          style: TextStyle(fontSize: 32,
              fontFamily: 'AppleGaramond',
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold),
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
                label: Text(item, style: TextStyle(color: Colors.greenAccent.shade400)),
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
              tableCell('Assets'),
              tableCell('+'),
              tableCell('Expenses'),
              tableCell('='),
              tableCell('Liabilities'),
              tableCell('+'),
              tableCell("Owner's Equity"),
              tableCell('+'),
              tableCell("Revenues"),
            ]),
            TableRow(children: [
              dragTargetCell('Assets_1'),
              dragTargetCell('+_1'),
              dragTargetCell('Expenses_1'),
              dragTargetCell('='),
              dragTargetCell('Liabilities_1'),
              dragTargetCell('+_2'),
              dragTargetCell('Equity_1'),
              dragTargetCell('+_3'),
              dragTargetCell('Revenues_1'),
            ]),
            TableRow(children: [
              dragTargetCell('Assets_2'),
              dragTargetCell('+_4'),
              dragTargetCell('Expenses_2'),
              dragTargetCell('='),
              dragTargetCell('Liabilities_2'),
              dragTargetCell('+_5'),
              dragTargetCell('Equity_2'),
              dragTargetCell('+_6'),
              dragTargetCell('Revenues_2'),
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
      color: Colors.greenAccent.shade200,
      child: Center(
        child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'GlacialIndifference', fontSize: 15)),
      ),
    );
  }
}