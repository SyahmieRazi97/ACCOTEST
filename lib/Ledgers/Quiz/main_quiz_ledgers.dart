import 'package:flutter/material.dart';
import 'package:smart_account/Ledgers/Quiz/easy_ledger.dart';
import 'package:smart_account/Ledgers/Quiz/hard_ledger.dart';
import 'package:smart_account/Ledgers/Quiz/medium_ledger.dart';

class MainQuizLedgers extends StatefulWidget {

  @override
  State<MainQuizLedgers> createState() => _MainQuizLedgersState();
}

class _MainQuizLedgersState extends State<MainQuizLedgers> {

  Widget buildFeatureButton({required String title, required IconData icon, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        backgroundColor: Colors.pinkAccent.shade200,
        foregroundColor: Colors.black,
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
        title: Text('Ledgers Quiz',
            style: TextStyle(fontFamily: 'AppleGaramond', fontSize: 31)
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent.shade200,
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => EasyLedger())
                );
              },
            ),
            SizedBox(height: 20),
            buildFeatureButton(
              title: 'MEDIUM',
              icon: Icons.sentiment_neutral,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MediumLedger())
                );
              },
            ),
            SizedBox(height: 20),
            buildFeatureButton(
              title: 'HARD',
              icon: Icons.sentiment_very_dissatisfied_outlined,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HardLedger())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}