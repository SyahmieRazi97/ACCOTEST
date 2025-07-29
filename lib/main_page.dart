import 'package:flutter/material.dart';
import 'package:smart_account/AccountingEquation/main_accounting_equation.dart';
import 'package:smart_account/JournalEntries/main_journal_entries.dart';
import 'package:smart_account/Ledgers/main_ledgers.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Widget buildFeatureButton({required String title, required IconData icon, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        backgroundColor: Colors.teal[400],
        foregroundColor: Colors.white,
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
        title: Text('ACCOTEST',
          style: TextStyle(
              fontFamily: 'AppleGaramond',
              fontWeight: FontWeight.bold,
              fontSize: 34,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildFeatureButton(
              title: 'Accounting Equation',
              icon: Icons.calculate,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainAccountingEquation()),
                );
              },
            ),
            SizedBox(height: 20),
            buildFeatureButton(
              title: 'Journal Entries',
              icon: Icons.book_rounded,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainJournalEntries())
                );
              },
            ),
            SizedBox(height: 20),
            buildFeatureButton(
              title: 'Ledgers',
              icon: Icons.list_alt_rounded,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainLedgers())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
