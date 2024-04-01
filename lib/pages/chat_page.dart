import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  List<ChatMessage> _messages = [];

  bool _istyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text('Te', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
            ),
            SizedBox(height: 3),
            Text('Melissa Flores',
                style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(children: [
          Flexible(
              child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (_, i) => _messages[i],
            itemCount: _messages.length,
            reverse: true,
          )),
          Divider(height: 1),
          Container(
            color: Colors.white,
            child: _inputChat(),
          )
        ]),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(children: [
        Flexible(
            child: TextField(
          controller: _textController,
          onSubmitted: _handleSubmit,
          onChanged: (text) {
            setState(() {
              if (text.trim().length > 0) {
                _istyping = true;
              } else {
                _istyping = false;
              }
            });
          },
          decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
          focusNode: _focusNode,
        )),
        // Boton de enviar
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: Platform.isIOS
              ? CupertinoButton(
                  child: Text('Enviar'),
                  onPressed: _istyping
                      ? () => _handleSubmit(_textController.text.trim())
                      : null)
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.send),
                        onPressed: _istyping
                            ? () => _handleSubmit(_textController.text.trim())
                            : null),
                  ),
                ),
        ),
      ]),
    ));
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;
    print(text);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      text: text,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _istyping = false;
    });
  }

  @override
  void dispose() {
    // TODO: off socket

    for (ChatMessage messages in _messages) {
      messages.animationController.dispose();
    }
    super.dispose();
  }
}
