import 'package:flutter/material.dart';
import 'package:smart_account/JournalEntries/Quiz/easy_journal_entry.dart';
import 'package:smart_account/JournalEntries/Quiz/hard_journal_entry.dart';
import 'package:smart_account/JournalEntries/Quiz/medium_journal_entry.dart';

class MainQuizJournalEntries extends StatefulWidget {

  @override
  State<MainQuizJournalEntries> createState() => _MainQuizJournalEntriesState();
}

class _MainQuizJournalEntriesState extends State<MainQuizJournalEntries> {

  Widget buildFeatureButton({required String title, required IconData icon, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        backgroundColor: Colors.blueAccent.shade200,
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
        title: Text('Journal Entries Quiz',
          style: TextStyle(fontFamily: 'AppleGaramond', fontSize: 30)
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade200,
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => EasyJournalEntry())
                );
              },
            ),
            SizedBox(height: 20),
            buildFeatureButton(
              title: 'MEDIUM',
              icon: Icons.sentiment_neutral,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MediumJournalEntry())
                );
              },
            ),
            SizedBox(height: 20),
            buildFeatureButton(
              title: 'HARD',
              icon: Icons.sentiment_very_dissatisfied_outlined,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HardJournalEntry())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}