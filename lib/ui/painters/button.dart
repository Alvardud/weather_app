import 'package:flutter/rendering.dart';
import 'package:weather_app/utils/configure.dart' as configure;

class ButtonPaint extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
    ..color = configure.convertColor("#011826").withOpacity(0.75)
    ..style = PaintingStyle.fill;

    var path = Path()
    ..quadraticBezierTo(
      size.width*0.1,
      size.height * 0.15,
      size.width*0.4,
      size.height * 0.3,
    )
    ..quadraticBezierTo(
      size.width*0.75,
      size.height * 0.50,
      size.width*0.4,
      size.height*0.7,
    )
    ..quadraticBezierTo(
      size.width*0.1,
      size.height * 0.85,
      size.width*0,
      size.height,
    )
    ..lineTo(0, size.height);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}