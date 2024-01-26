import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            _Logo(),
          ],
        )));
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/chat_heart.png')),
            SizedBox(height: 20),
            Text('Messenger', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
