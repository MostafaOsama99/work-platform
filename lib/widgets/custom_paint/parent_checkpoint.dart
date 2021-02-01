import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:project/constants.dart';

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color = COLOR_BACKGROUND
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path_0 = Path();
    path_0.moveTo(0,size.height*0.17);
    path_0.quadraticBezierTo(size.width*0.01,size.height*0.12,size.width*0.04,size.height*0.12);
    path_0.cubicTo(size.width*0.15,size.height*0.12,size.width*0.35,size.height*0.12,size.width*0.46,size.height*0.12);
    path_0.cubicTo(size.width*0.50,size.height*0.12,size.width*0.46,0,size.width*0.50,0);
    path_0.cubicTo(size.width*0.61,0,size.width*0.84,0,size.width*0.96,0);
    path_0.quadraticBezierTo(size.width*0.99,size.height*-0.00,size.width,size.height*0.08);
    path_0.quadraticBezierTo(size.width,size.height*0.71,size.width,size.height*0.92);
    path_0.quadraticBezierTo(size.width*1.00,size.height*0.98,size.width*0.96,size.height);
    path_0.lineTo(size.width*0.04,size.height);
    path_0.quadraticBezierTo(size.width*-0.00,size.height*0.99,0,size.height*0.92);
    path_0.quadraticBezierTo(0,size.height*0.73,0,size.height*0.17);
    path_0.close();

    canvas.drawPath(path_0, paint_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
