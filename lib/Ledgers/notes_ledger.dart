import 'package:flutter/material.dart';

class NotesLedger extends StatelessWidget {

  final List<String> imagePaths = [
    'assets/images/notes/ledger/Slide1.PNG',
    'assets/images/notes/ledger/Slide2.PNG',
    'assets/images/notes/ledger/Slide3.PNG',
    'assets/images/notes/ledger/Slide4.PNG',
    'assets/images/notes/ledger/Slide5.PNG',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ledger Note',
            style: TextStyle(fontFamily: 'AppleGaramond', fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent.shade200,
      ),
      body: PageView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            panEnabled: true,
            minScale: 1,
            maxScale: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                imagePaths[index],
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
