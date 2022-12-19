import 'package:flutter/material.dart';

class Cards extends StatelessWidget {

  final String visitor;
  final String fecha;
  const Cards({super.key, required this.visitor, required this.fecha});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      color:Colors.white,
      child: Card(
              child: ListTile(
                leading: Icon(Icons.album),
                title: Text(visitor),
                subtitle: Text(fecha),
              ),
            ),
    );
  }
}