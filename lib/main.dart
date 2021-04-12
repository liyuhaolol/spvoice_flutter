import 'package:flutter/material.dart';

void main() {
  runApp(App());
  //MediaQuery.of(context)
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.blueGrey,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
          child: Container(
            color: Colors.amber,
            child: SizedBox(
              height: MediaQuery.of(context).padding.bottom,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}




