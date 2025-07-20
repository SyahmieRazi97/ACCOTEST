import 'package:flutter/material.dart';
import 'package:smart_account/AccountingEquation/Quiz/main_quiz_accounting_equation.dart';
import 'package:smart_account/AccountingEquation/notes_accounting_equation.dart';

class MainAccountingEquation extends StatefulWidget {

  @override
  State<MainAccountingEquation> createState() => _MainAccountingEquationState();
}

class _MainAccountingEquationState extends State<MainAccountingEquation> {

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
        title: Text('Accounting Equation',
          style: TextStyle(fontFamily: 'AppleGaramond', fontSize: 30),
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
              title: 'Notes',
              icon: Icons.notes,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesAccountingEquation())
                );
              },
            ),
            SizedBox(height: 30),
            buildFeatureButton(
              title: 'Quiz',
              icon: Icons.quiz_outlined,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainQuizAccountingEquation())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
