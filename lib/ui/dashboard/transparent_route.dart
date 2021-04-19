import 'package:customer/ui/dashboard/dashboard_filter.dart';
import 'package:flutter/material.dart';

class TransparentRoute extends ModalRoute<void> {

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: DashboardFilterPage()
    );
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
       // child: result,
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );

  }

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => false;
}
