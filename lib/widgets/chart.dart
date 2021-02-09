import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.grey[350],
      child: Card(
        margin: EdgeInsets.all(2),
        child: Text('chart'),
      ),
    );
  }
}
