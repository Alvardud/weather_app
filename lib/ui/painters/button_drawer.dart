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
      size.width*0.05,
      size.height * 0.15,
      size.width*0.13,
      size.height * 0.33,
    )
    ..quadraticBezierTo(
      size.width*0.18,
      size.height * 0.50,
      size.width*0.13,
      size.height*0.66,
    )
    ..quadraticBezierTo(
      size.width*0.05,
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