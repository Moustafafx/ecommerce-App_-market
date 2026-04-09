import 'package:flutter/material.dart';

class coustomtext extends StatelessWidget {
  const coustomtext({
    super.key, required this.text,  this.fontSize,  this.fontWeight,  this.color,
  });
final String text;
final double? fontSize;
final FontWeight ?fontWeight;
final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
      color:color ,
      fontSize:fontSize ,
      fontWeight:fontWeight, 
    ),);
  }
}