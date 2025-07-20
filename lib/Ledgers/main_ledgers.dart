import 'package:flutter/material.dart';
import 'package:smart_account/Ledgers/Quiz/main_quiz_ledgers.dart';
import 'package:smart_account/Ledgers/notes_ledger.dart';

class MainLedgers extends StatefulWidget {

  @override
  State<MainLedgers> createState() => _MainLedgersState();
}

class _MainLedgersState extends State<MainLedgers> {

  Widget buildFeatureButton({required String title, required IconData icon, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        backgroundColor: Colors.pinkAccent.shade200,
        foregroundColor: Colors.black,
        textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'GlacialIndifference'),
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
      backgroundColor: Colors.blueGrey[50] ,
      appBar: AppBar(
        title: Text('Ledgers',
          style: TextStyle(fontFamily: 'AppleGaramond', fontSize: 30),
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
              title: 'Notes',
              icon: Icons.notes,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesLedger())
                );
              },
            ),
            SizedBox(height: 30),
            buildFeatureButton(
              title: 'Quiz',
              icon: Icons.quiz_outlined,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainQuizLedgers())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
