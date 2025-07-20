import 'package:flutter/material.dart';

class NotesJournalEntries extends StatelessWidget {

  final List<String> imagePaths = [
    'Assets/images/notes/journeyentry/Slide1.PNG',
    'Assets/images/notes/journeyentry/Slide2.PNG',
    'Assets/images/notes/journeyentry/Slide3.PNG',
    'Assets/images/notes/journeyentry/Slide4.PNG',
    'Assets/images/notes/journeyentry/Slide5.PNG',
    'Assets/images/notes/journeyentry/Slide6.PNG',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journey Entry Note',
            style: TextStyle(fontFamily: 'AppleGaramond')
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade200,
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
