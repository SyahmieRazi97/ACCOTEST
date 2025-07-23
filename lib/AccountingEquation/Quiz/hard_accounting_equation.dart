import 'dart:async';
import 'package:flutter/material.dart';

class HardAccountingEquation extends StatefulWidget {

  @override
  State<HardAccountingEquation> createState() => _HardAccountingEquationState();
}

class MapEquality {
  bool equals(Map<String, String> a, Map<String, String> b) {
    for (var key in a.keys) {
      if (a[key] != b[key] && b.containsKey(key)) return false;
    }
    return true;
  }
}

class _HardAccountingEquationState extends State<HardAccountingEquation> {

  int countdown = 5;
  bool isCountdown = true;
  Timer? countdownTimer;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Started business with RM 30,000 in bank, RM 30,000 cash and RM 20,000 furniture',
      'choices': ['Cash +30,000', 'Cash -30,000', 'Bank +30,000', 'Bank -30,000', 'Furniture +20,000', 'Furniture -20,000', 'Capital +80,000', 'Capital -80,000'],
      'correct': {
        'Assets_1': 'Cash +30,000',
        'Assets_2': 'Bank +30,000',
        'Assets_3': 'Furniture +20,000',
        '+_1': '',
        '+_4': '',
        '+_7': '',
        'Expenses_1': '',
        'Expenses_2': '',
        'Expenses_3': '',
        '=': '',
        'Liabilities_1': '',
        'Liabilities_2': '',
        'Liabilities_3': '',
        '+_2': '',
        '+_5': '',
        '+_8': '',
        'Equity_1': 'Capital +80,000',
        'Equity_2': '',
        'Equity_3': '',
        '+_3': '',
        '+_6': '',
        '+_9': '',
        'Revenues_1': '',
        'Revenues_2': '',
        'Revenues_3': '',
      },
    },
    {
      'question': 'Received invoice from Ketapang Enterprise RM 10,000',
      'choices': ['Purchase +10,000', 'Purchase -10,000', 'Sales +10,000', 'Sales -10,000', 'Acc. Payable Ketapang Ent +10,000', 'Acc. Payable Ketapang Ent -10,000', 'Acc. Receivable Ketapang Ent +10,000', 'Acc. Receivable Ketapang Ent -10,000'],
      'correct': {
        'Assets_1': '',
        'Assets_2': '',
        'Assets_3': '',
        '+_1': '',
        '+_4': '',
        '+_7': '',
        'Expenses_1': 'Purchase +10,000',
        'Expenses_2': '',
        'Expenses_3': '',
        '=': '',
        'Liabilities_1': 'Acc. Payable Ketapang Ent +10,000',
        'Liabilities_2': '',
        'Liabilities_3': '',
        '+_2': '',
        '+_5': '',
        '+_8': '',
        'Equity_1': '',
        'Equity_2': '',
        'Equity_3': '',
        '+_3': '',
        '+_6': '',
        '+_9': '',
        'Revenues_1': '',
        'Revenues_2': '',
        'Revenues_3': '',
      },
    },
    {
      'question': 'Sent invoice to Markisar Enterprise RM 2,000',
      'choices': ['Purchase +2,000', 'Purchase -2,000', 'Sales +2,000', 'Sales -2,000', 'Acc. Payable Markisar Ent +2,000', 'Acc. Payable Markisar Ent -2,000', 'Acc. Receivable Markisar Ent +2,000', 'Acc. Receivable Markisar Ent -2,000'],
      'correct': {
        'Assets_1': 'Acc. Receivable Markisar Ent +2,000',
        'Assets_2': '',
        'Assets_3': '',
        '+_1': '',
        '+_4': '',
        '+_7': '',
        'Expenses_1': '',
        'Expenses_2': '',
        'Expenses_3': '',
        '=': '',
        'Liabilities_1': '',
        'Liabilities_2': '',
        'Liabilities_3': '',
        '+_2': '',
        '+_5': '',
        '+_8': '',
        'Equity_1': '',
        'Equity_2': '',
        'Equity_3': '',
        '+_3': '',
        '+_6': '',
        '+_9': '',
        'Revenues_1': 'Sales +2,000',
        'Revenues_2': '',
        'Revenues_3': '',
      },
    },
    {
      'question': 'Received defective goods from Markisar Enterprise RM 200',
      'choices': ['Return Purchase +200', 'Return Purchase -200', 'Return Sales +200', 'Return Sales -200', 'Acc. Receivable Markisar Ent +200', 'Acc. Receivable Markisar Ent -200'],
      'correct': {
        'Assets_1': 'Acc. Receivable Markisar Ent -200',
        'Assets_2': '',
        'Assets_3': '',
        '+_1': '',
        '+_4': '',
        '+_7': '',
        'Expenses_1': '',
        'Expenses_2': '',
        'Expenses_3': '',
        '=': '',
        'Liabilities_1': '',
        'Liabilities_2': '',
        'Liabilities_3': '',
        '+_2': '',
        '+_5': '',
        '+_8': '',
        'Equity_1': '',
        'Equity_2': '',
        'Equity_3': '',
        '+_3': '',
        '+_6': '',
        '+_9': '',
        'Revenues_1': 'Return Sales -200',
        'Revenues_2': '',
        'Revenues_3': '',
      },
    },
    {
      'question': 'The business paid all outstanding amounts by cheque to Ketapang Enterprise. Received a discount of 5% discount',
      'choices': ['Bank +9,500', 'Bank -9,500', 'Bank +10,000', 'Bank -10,000', 'Discount allowed +500', 'Discount allowed -500', 'Discount received +500', 'Discount received -500', 'Acc. Payable Ketapang Ent +10,000', 'Acc. Payable Ketapang Ent -10,000'],
      'correct': {
        'Assets_1': 'Bank -9,500',
        'Assets_2': '',
        'Assets_3': '',
        '+_1': '',
        '+_4': '',
        '+_7': '',
        'Expenses_1': '',
        'Expenses_2': '',
        'Expenses_3': '',
        '=': '',
        'Liabilities_1': 'Acc. Payable Ketapang Ent -10,000',
        'Liabilities_2': '',
        'Liabilities_3': '',
        '+_2': '',
        '+_5': '',
        '+_8': '',
        'Equity_1': '',
        'Equity_2': '',
        'Equity_3': '',
        '+_3': '',
        '+_6': '',
        '+_9': '',
        'Revenues_1': 'Discount received +500',
        'Revenues_2': '',
        'Revenues_3': '',
      },
    },
    {
      'question': 'Paid shop rent by cheque RM 1,700 and salary to workers RM 1,500 by cheque',
      'choices': ['Rental +1,700', 'Rental -1,700', 'Salary +1,500', 'Salary -1,500', 'Bank +3,200', 'Bank -3,200'],
      'correct': {
        'Assets_1': 'Bank -3,200',
        'Assets_2': '',
        'Assets_3': '',
        '+_1': '',
        '+_4': '',
        '+_7': '',
        'Expenses_1': 'Rental +1,700',
        'Expenses_2': 'Salary +1,500',
        'Expenses_3': '',
        '=': '',
        'Liabilities_1': '',
        'Liabilities_2': '',
        'Liabilities_3': '',
        '+_2': '',
        '+_5': '',
        '+_8': '',
        'Equity_1': '',
        'Equity_2': '',
        'Equity_3': '',
        '+_3': '',
        '+_6': '',
        '+_9': '',
        'Revenues_1': '',
        'Revenues_2': '',
        'Revenues_3': '',
      },
    },
  ];

  int currentQuestion = 0;
  int score = 0;
  int secondsRemaining = 120;
  Timer? timer;
  bool isSubmitted = false;

  Map<String, String> droppedSymbols = {
    'Assets_1': '',
    'Assets_2': '',
    'Assets_3': '',
    '+_1': '',
    '+_4': '',
    '+_7': '',
    'Expenses_1': '',
    'Expenses_2': '',
    'Expenses_3': '',
    '=': '',
    'Liabilities_1': '',
    'Liabilities_2': '',
    'Liabilities_3': '',
    '+_2': '',
    '+_5': '',
    '+_8': '',
    'Equity_1': '',
    'Equity_2': '',
    'Equity_3': '',
    '+_3': '',
    '+_6': '',
    '+_9': '',
    'Revenues_1': '',
    'Revenues_2': '',
    'Revenues_3': '',
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
      'Assets_1': '',
      'Assets_2': '',
      'Assets_3': '',
      '+_1': '',
      '+_4': '',
      '+_7': '',
      'Expenses_1': '',
      'Expenses_2': '',
      'Expenses_3': '',
      '=': '',
      'Liabilities_1': '',
      'Liabilities_2': '',
      'Liabilities_3': '',
      '+_2': '',
      '+_5': '',
      '+_8': '',
      'Equity_1': '',
      'Equity_2': '',
      'Equity_3': '',
      '+_3': '',
      '+_6': '',
      '+_9': '',
      'Revenues_1': '',
      'Revenues_2': '',
      'Revenues_3': '',
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
          'Assets_3': '',
          '+_1': '',
          '+_4': '',
          '+_7': '',
          'Expenses_1': '',
          'Expenses_2': '',
          'Expenses_3': '',
          '=': '',
          'Liabilities_1': '',
          'Liabilities_2': '',
          'Liabilities_3': '',
          '+_2': '',
          '+_5': '',
          '+_8': '',
          'Equity_1': '',
          'Equity_2': '',
          'Equity_3': '',
          '+_3': '',
          '+_6': '',
          '+_9': '',
          'Revenues_1': '',
          'Revenues_2': '',
          'Revenues_3': '',
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
                  'Assets_3': '',
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
        title: Text('Accounting Equation Hard Quiz',
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
            TableRow(children: [
              dragTargetCell('Assets_3'),
              dragTargetCell('+_7'),
              dragTargetCell('Expenses_3'),
              dragTargetCell('='),
              dragTargetCell('Liabilities_3'),
              dragTargetCell('+_8'),
              dragTargetCell('Equity_3'),
              dragTargetCell('+_9'),
              dragTargetCell('Revenues_3'),
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