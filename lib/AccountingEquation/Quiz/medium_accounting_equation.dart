import 'dart:async';
import 'package:flutter/material.dart';

class MediumAccountingEquation extends StatefulWidget {

  @override
  State<MediumAccountingEquation> createState() => _MediumAccountingEquationState();
}

class MapEquality {
  bool equals(Map<String, String> a, Map<String, String> b) {
    for (var key in a.keys) {
      if (a[key] != b[key] && b.containsKey(key)) return false;
    }
    return true;
  }
}

class _MediumAccountingEquationState extends State<MediumAccountingEquation> {

  int countdown = 5;
  bool isCountdown = true;
  Timer? countdownTimer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Started business with cash in hand RM 20,000 and brought in vehicle RM 70,000 into the business',
      'choices': ['Cash +20,000', 'Cash -20,000', 'Capital +90,000', 'Capital -90,000', 'Vehicle +70,000', 'Vehicle -70,000'],
      'correct': {
        'Assets_1': 'Cash +20,000',
        'Assets_2': 'Vehicle +70,000',
        '+_1':'',
        '+_4':'',
        'Expenses_1': '',
        'Expenses_2': '',
        '=':'',
        'Liabilities_1': '',
        'Liabilities_2': '',
        '+_2':'',
        '+_5':'',
        'Equity_1': 'Capital +90,000',
        'Equity_2': '',
        '+_3':'',
        '+_6':'',
        'Revenues_1': '',
        'Revenues_2': '',
      },
    },
    {
      'question': 'Bought goods RM 10,000 on credit from Melhor Enterprise and received 10% trade discount',
      'choices': ['Acc. Payable Melhor Ent +9,000', 'Acc. Payable Melhor Ent -9,000', 'Acc. Payable Melhor Ent +10,000', 'Acc. Payable Melhor Ent +10,000', 'Purchase +9,000', 'Purchase -9,000', 'Purchase +10,000', 'Purchase -10,000'],
      'correct': {
        'Assets_1': '',
        'Assets_2': '',
        '+_1':'',
        '+_4':'',
        'Expenses_1': 'Purchase +9,000',
        'Expenses_2': '',
        '=':'',
        'Liabilities_1': 'Acc. Payable Melhor Ent +9,000',
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
      'question': 'Sold goods on credit to Haura Enterprise RM 6,000',
      'choices': ['Acc. Receivable Haura Ent +6,000', 'Acc. Receivable Haura Ent -6,000', 'Sales +6,000', 'Sales -6,000'],
      'correct': {
        'Assets_1': 'Acc. Receivable Haura Ent +6,000',
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
        'Revenues_1': 'Sales +6,000',
        'Revenues_2': '',
      },
    },
    {
      'question': 'Returned damaged goods to Melhor Enterprise RM 200',
      'choices': ['Acc. Payable Melhor Ent +200', 'Acc. Payable Melhor Ent -200', 'Return Purchase +200', 'Return Purchase -200'],
      'correct': {
        'Assets_1': '',
        'Assets_2': '',
        '+_1':'',
        '+_4':'',
        'Expenses_1': 'Return Purchase -200',
        'Expenses_2': '',
        '=':'',
        'Liabilities_1': 'Acc. Payable Melhor Ent -200',
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
      'question': 'Mr Kan Tan took cash to pay for her personal expenses RM800',
      'choices': ['Cash +800', 'Cash -800', 'Drawings +800', 'Drawings -800'],
      'correct': {
        'Assets_1': 'Cash -800',
        'Assets_2': '',
        '+_1':'',
        '+_4':'',
        'Expenses_1': 'Return Purchase -200',
        'Expenses_2': '',
        '=':'',
        'Liabilities_1': 'Acc. Payable Melhor Ent -200',
        'Liabilities_2': '',
        '+_2':'',
        '+_5':'',
        'Equity_1': 'Drawings -800',
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
  int secondsRemaining = 60;
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
        title: Text('Accounting Equation Medium Quiz',
          style: TextStyle(fontFamily: 'AppleGaramond', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade400,
      ),
      body: isCountdown
          ? Center(
        child: Text(
          'Get ready in $countdown...',
          style: TextStyle(fontSize: 32, fontFamily: 'AppleGaramond'),
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