import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///this provider handles when to show or hide bottom navigation bar

class NavBar extends ChangeNotifier {
  Animation _animation;
  AnimationController _animationController;
  ScrollController _scrollController;

  // NavBar(){
  //   _scrollController = ScrollController();
  // }

  set scrollController(ScrollController scrollController) {
    _scrollController = scrollController;
    _scrollController.addListener(_toggleNavBar);
    _scrollController.notifyListeners();
  }

  ScrollController get scrollController => _scrollController;

  removeController() {
    showNavBar();
    _scrollController.removeListener(_toggleNavBar);
    _scrollController = null;
  }

  double _navBarHeight;

  //according to nav bar top value (outside top curve)
  double _topValue = -12;

  double get navBarHeight => _navBarHeight;

  double get navBarTopValue => _topValue;

  bool calculating = false;

  _toggleNavBar() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse)
      hideNavBar();
    else
      showNavBar();
  }

  showNavBar() {
    _navBarHeight = 44;
    _topValue = -12;
    notifyListeners();
  }

  hideNavBar() {
    _navBarHeight = 0;
    _topValue = 0;
    notifyListeners();
  }

// calculateNavBarHeight() {
//   if (calculating) return;
//   calculating = true;
//   if ((_scrollController != null
//           ? _scrollController.position.userScrollDirection
//           : ScrollDirection.forward) ==
//       ScrollDirection.reverse)
//     _navBarHeight = 0;
//   else
//     _navBarHeight = 44;
//   Future.delayed(Duration(milliseconds: 200));
//   calculating = false;
//   return _navBarHeight;
// }
}
