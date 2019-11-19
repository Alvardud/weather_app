import 'package:flutter/material.dart';
import 'package:weather_app/ui/painters/button.dart';

class Search extends StatelessWidget {
  Widget _button() {
    return SizedBox(
      height: 120.0,
      width: 100.0,
          child: InkWell(
          onTap: () {},
          child: CustomPaint(
            painter: ButtonPaint(),
            child: Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.menu,color: Colors.white,),
              ),
            )
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 180.0,
          bottom: 16.0,
          //left: 16.0,
          right: 16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(bottom: 0.0, left: 0.0, child: _button())
          ],
        ),
      ),
    );
  }
}
