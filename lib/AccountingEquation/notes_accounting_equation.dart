import 'package:flutter/material.dart';

class NotesAccountingEquation extends StatelessWidget {

  final List<String> imagePaths = [
    'Assets/images/notes/accountingequation/Slide1.PNG',
    'Assets/images/notes/accountingequation/Slide2.PNG',
    'Assets/images/notes/accountingequation/Slide3.PNG',
    'Assets/images/notes/accountingequation/Slide4.PNG',
    'Assets/images/notes/accountingequation/Slide5.PNG',
    'Assets/images/notes/accountingequation/Slide6.PNG',
    'Assets/images/notes/accountingequation/Slide7.PNG',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounting Equation Note',
            style: TextStyle(fontFamily: 'AppleGaramond')
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade400,
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
