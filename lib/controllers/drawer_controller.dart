import 'package:flutter/widgets.dart';

class CustomDrawerController extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;
  CustomDrawerState state = CustomDrawerState.closed;

  CustomDrawerController({
    this.vsync,
  }) : _animationController = AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 150)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = CustomDrawerState.opening;
            break;
          case AnimationStatus.reverse:
            state = CustomDrawerState.closing;
            break;
          case AnimationStatus.completed:
            state = CustomDrawerState.open;
            break;
          case AnimationStatus.dismissed:
            state = CustomDrawerState.closed;
            break;
        }
        notifyListeners();
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen => _animationController.value;

  open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  toggle() {
    if (state == CustomDrawerState.open) {
      close();
    } else if (state == CustomDrawerState.closed) {
      open();
    }
  }
}

enum CustomDrawerState {
  closed,
  opening,
  open,
  closing,
}
