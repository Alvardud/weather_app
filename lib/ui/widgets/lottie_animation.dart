import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:lottie_flutter/lottie_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LottieAnimation extends StatefulWidget {
  final String animation;
  final double size;
  LottieAnimation({this.animation, this.size = 150.0});

  @override
  _LottieAnimationState createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation>
    with SingleTickerProviderStateMixin {
  LottieComposition _composition;
  AnimationController _controller;
  bool _repeat;

  @override
  void initState() {
    super.initState();
    _repeat = true;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    );
    loadAsset(widget.animation).then((LottieComposition composition) {
      setState(() {
        _composition = composition;
        _controller.reset();
      });
    });
    _controller.addListener(() => setState(() {
          if (_controller.isAnimating) {
            _controller.repeat();
          } else {
            if (_repeat) {
              _controller.repeat();
            } else {
              _controller.forward();
            }
          }
        }));
  }
/*
  void _play() {
    setState(() {
      if (_controller.isAnimating) {
        _controller.stop();
      } else {
        if (_repeat) {
          _controller.repeat();
        } else {
          _controller.forward();
        }
      }
    });
  }*/

  Future<LottieComposition> loadAsset(String assetName) async {
    return await rootBundle
        .loadString(assetName)
        .then<Map<String, dynamic>>((String data) => json.decode(data))
        .then((Map<String, dynamic> map) => LottieComposition.fromMap(map));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Lottie(
          composition: _composition,
          size: Size(widget.size, widget.size),
          controller: _controller,
        ),
      ),
    );
  }
}

///Controllers
/*Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            IconButton(
              icon: const Icon(Icons.repeat),
              color: _repeat ? Colors.black : Colors.black45,
              onPressed: () => setState(() {
                _repeat = !_repeat;
                if (_controller.isAnimating) {
                  if (_repeat) {
                    _controller
                        .forward()
                        .then<Null>((nul) => _controller.repeat());
                  } else {
                    _controller.forward();
                  }
                }
              }),
            ),
            IconButton(
              icon: const Icon(Icons.fast_rewind),
              onPressed: _controller.value > 0 && _composition != null
                  ? () => setState(() => _controller.reset())
                  : null,
            ),
            IconButton(
                icon: _controller.isAnimating
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
                onPressed:
                    _controller.isCompleted || _composition == null ? null : _play
                () {
                        setState(() {
                          if (_controller.isAnimating) {
                            _controller.stop();
                          } else {
                            if (_repeat) {
                              _controller.repeat();
                            } else {
                              _controller.forward();
                            }
                          }
                        });
                      }
                ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: _controller.isAnimating && _composition != null
                  ? () {
                      _controller.reset();
                    }
                  : null,
            ),
          ]
          ),*/
