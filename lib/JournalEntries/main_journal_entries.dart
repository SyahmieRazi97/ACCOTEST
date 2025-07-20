import 'package:flutter/material.dart';
import 'package:smart_account/JournalEntries/Quiz/main_quiz_journal_entries.dart';
import 'package:smart_account/JournalEntries/notes_journal_entries.dart';

class MainJournalEntries extends StatefulWidget {

  @override
  State<MainJournalEntries> createState() => _MainJournalEntriesState();
}

class _MainJournalEntriesState extends State<MainJournalEntries> {

  Widget buildFeatureButton({required String title, required IconData icon, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        backgroundColor: Colors.blueAccent.shade200,
        foregroundColor: Colors.black,
        textStyle: TextStyle(fontSize: 22, fontFamily: 'GlacialIndifference', fontWeight: FontWeight.bold),
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
        title: Text('Journal Entries',
          style: TextStyle(fontFamily: 'AppleGaramond', fontSize: 30),
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
              title: 'Notes',
              icon: Icons.notes,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotesJournalEntries())
                );
              },
            ),
            SizedBox(height: 30),
            buildFeatureButton(
              title: 'Quiz',
              icon: Icons.quiz_outlined,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainQuizJournalEntries())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
