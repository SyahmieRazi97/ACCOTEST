import 'package:flutter/material.dart';
import 'package:smart_account/AccountingEquation/Quiz/easy_accounting_equation.dart';
import 'package:smart_account/AccountingEquation/Quiz/hard_accounting_equation.dart';
import 'package:smart_account/AccountingEquation/Quiz/medium_accounting_equation.dart';

class MainQuizAccountingEquation extends StatefulWidget {

  @override
  State<MainQuizAccountingEquation> createState() => _MainQuizAccountingEquationState();
}

class _MainQuizAccountingEquationState extends State<MainQuizAccountingEquation> {

  Widget buildFeatureButton({required String title, required IconData icon, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        backgroundColor: Colors.greenAccent.shade400,
        foregroundColor: Colors.black,
        textStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, fontFamily: 'GlacialIndifference'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 28),
      label: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('Accounting Equation Quiz',
          style: TextStyle(fontFamily: 'AppleGaramond'),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildFeatureButton(
              icon: Icons.sentiment_satisfied_alt,
              title: 'EASY',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EasyAccountingEquation())
                );
              },
            ),
            SizedBox(height: 20),
            buildFeatureButton(
              title: 'MEDIUM',
              icon: Icons.sentiment_neutral,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MediumAccountingEquation())
                );
              },
            ),
            SizedBox(height: 20),
            buildFeatureButton(
              title: 'HARD',
              icon: Icons.sentiment_very_dissatisfied_outlined,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HardAccountingEquation())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}