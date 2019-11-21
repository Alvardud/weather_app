import 'dart:ui';
import 'package:flutter/material.dart';


class Prueba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContenedorPromociones(),
    );
  }
}

class ContenedorPromociones extends StatefulWidget {
  @override
  _ContenedorPromocionState createState() => _ContenedorPromocionState();
}

class _ContenedorPromocionState extends State<ContenedorPromociones> {

  double scrollPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Expanded(
            child: CardFlipper(
              onScroll: (double scrollPercent){
                setState((){
                  this.scrollPercent=scrollPercent;
                });
              },
            ),
          ),
          Container(
            height: 50.0,
            //este contenedor contiene el controlador de las promociones
            child: BottomBar(
                cardCount: 3,
                scrollPercent:scrollPercent,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  BottomBar({
    this.scrollPercent, this.cardCount
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width/2.5,
        height: 5.0,
        child: ScrollIndicator(
          cardCount: cardCount,
          scrollPercent: scrollPercent,
        ),
      ),
    );
  }
}

class ScrollIndicator extends StatelessWidget {

  final int cardCount;
  final double scrollPercent;

  ScrollIndicator({
    this.cardCount,this.scrollPercent
  });
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScrollIndicatorPainter(
        cardCount: cardCount,
        scrollPercent: scrollPercent,
      ),
      child: Container(),
    );
  }
}

class ScrollIndicatorPainter extends CustomPainter{

  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({
    this.cardCount,
    this.scrollPercent
  }): trackPaint = new Paint()
    ..color = Colors.black38
    ..style = PaintingStyle.fill,
    thumbPaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    //draw track
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(
                0.0,
                0.0,
                size.width,
                size.height
            ),
          topLeft: Radius.circular(3.0),
          bottomLeft: Radius.circular(3.0),
          topRight: Radius.circular(3.0),
          bottomRight: Radius.circular(3.0),
        ),
        trackPaint);

    // Draw thumb
    final thumbWidth = size.width/ cardCount;
    final thumbLeft = scrollPercent * size.width;

    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              thumbLeft,
              0.0,
              thumbWidth,
              size.height
          ),
          topLeft: Radius.circular(3.0),
          bottomLeft: Radius.circular(3.0),
          topRight: Radius.circular(3.0),
          bottomRight: Radius.circular(3.0),
        ),
        thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class CardFlipper extends StatefulWidget {

  final Function(double scrollPercent) onScroll;

  CardFlipper({
    this.onScroll,
  });

  @override
  _CardFlipperState createState() => _CardFlipperState();
}

class _CardFlipperState extends State<CardFlipper> with TickerProviderStateMixin{

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
      duration: const Duration(milliseconds: 150),
      vsync: this
    )
    ..addListener((){
      setState(() {
        scrollPercent =
            lerpDouble(finishScrollStart,finishScrollEnd,finishScrollController.value);

        if(widget.onScroll != null){
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

  void _onHorizontalDragStart(DragStartDetails details){
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details){
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    final singleCardDragPercent = dragDistance / context.size.width;

    final numCards = 3;
    setState(() {
      scrollPercent = (startDragPercentScroll + (-singleCardDragPercent/numCards))
          .clamp(0.0, 1.0 - (1/numCards));

      if(widget.onScroll != null){
        widget.onScroll(scrollPercent);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details){
    final numCards = 3;

    finishScrollStart = scrollPercent;
    finishScrollEnd = (scrollPercent * numCards).round()/numCards;
    finishScrollController.forward(from: 0.0);

    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }

  List<Widget> _buildCards(){
    return[
      _buildCard(0,3,scrollPercent),
      _buildCard(1,3,scrollPercent),
      _buildCard(2,3,scrollPercent),
    ];
  }

  Widget _buildCard(int cardIndex, int cardCount, double scrollPercent){
    final cardScrollPercent = scrollPercent / (1/cardCount);

    return FractionalTranslation(
      translation: Offset(cardIndex-cardScrollPercent, 0.0),
      child: Promocion(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: _buildCards(),
    )
    );
  }
}

class Promocion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:100.0,right: 16.0),
      color: Colors.red,
      height: 200.0,
      width: 200.0,
    );
  }
}
