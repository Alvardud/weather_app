import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:weather_app/controllers/drawer_controller.dart';
import 'package:weather_app/ui/pages/prueba.dart';
import 'package:weather_app/ui/painters/button_drawer.dart';
import 'package:weather_app/utils/configure.dart' as configure;

class Search extends StatefulWidget {
  final Function(double) onScroll;
  Search({this.onScroll});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;

  @override
  void initState() {
    super.initState();
    finishScrollController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this)
      ..addListener(() {
        setState(() {
          scrollPercent = ui.lerpDouble(
              finishScrollStart, finishScrollEnd, finishScrollController.value);

          if (widget.onScroll != null) {
            widget.onScroll(scrollPercent);
          }
        });
      });
  }

  @override
  void dispose() {
    finishScrollController.dispose();
    super.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    final singleCardDragPercent = dragDistance / context.size.width;

    setState(() {
      scrollPercent = (startDragPercentScroll + (singleCardDragPercent / 2))
          .clamp(0.0, 1.0 - (1 / 2));

      if (widget.onScroll != null) {
        widget.onScroll(scrollPercent);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    finishScrollStart = scrollPercent;
    finishScrollEnd = (scrollPercent * 2).round() / 2;
    finishScrollController.forward(from: 0.0);

    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }

  void _open() {
    setState(() {});
  }

  void _close() {
    setState(() {});
  }

  Widget _button(BuildContext context, int cardIndex, int cardCount,
      double scrollPercent) {
    final cardScrollPercent = scrollPercent / (1 / cardCount);
    return SizedBox(
      height: 120.0,
      width: MediaQuery.of(context).size.width,
      child: FractionalTranslation(
        translation: Offset(cardScrollPercent, 0.0),
        child: CustomPaint(
            size: const Size(100.0, 120.0),
            painter: ButtonPaint(),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onHorizontalDragStart: _onHorizontalDragStart,
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  onTap: () {
                    print('presionado');
                    setState(() {
                      scrollPercent = -200.0;
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      ),
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
            Transform.translate(
                offset: Offset(
                    0.0, MediaQuery.of(context).size.height * 0.5 - 24.0),
                child: _button(context, 1, 2, scrollPercent)),
            Transform.translate(
              offset: Offset(-MediaQuery.of(context).size.width + 16.0, 0.0),
              child: FractionalTranslation(
                translation: Offset(scrollPercent * 2, 0.0),
                child: GestureDetector(
                  onHorizontalDragStart: _onHorizontalDragStart,
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color:
                          configure.convertColor("#011826").withOpacity(0.75),
                    ),
                    margin: EdgeInsets.only(left: 16.0),
                    child: Center(
                      child: FlatButton(
                        onPressed: () {
                          scrollPercent = 0.0;
                        },
                        child: Text(
                          'Cerrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
