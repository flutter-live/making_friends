import 'package:flutter/material.dart';

/// @description： 昵称，职业，情感
/// @author：liuzhidong
/// @date：2020/4/6 17:46
/// @version：1.0

class EditingFromPage extends StatefulWidget {
  final String title;
  final String hintText;

  const EditingFromPage({Key key, this.title, this.hintText}) : super(key: key);

  @override
  _EditingFromPageState createState() => _EditingFromPageState();
}

class _EditingFromPageState extends State<EditingFromPage> {
  String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: widget.hintText,
                ),
                onSubmitted: (value){
                  setState(() {
                    text = value;
                  });
                },
                onChanged: (value){
                  setState(() {
                    text = value;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              child: RaisedButton(
                onPressed: () => Navigator.of(context).pop(text),
                child: Text(
                  '完成',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 3,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

