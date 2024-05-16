import 'package:flutter/material.dart';


class ChatLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          DotLoader(),
          SizedBox(width: 10),
          DotLoader(),
          SizedBox(width: 10),
          DotLoader(),
        ],
      ),
    );
  }
}

class DotLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 5),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
