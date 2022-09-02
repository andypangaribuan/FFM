/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

import 'package:flutter/material.dart';

class FSimpleButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? splashColor;
  final double elevation;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final VoidCallback? onTap;

  /// Rounded: use CircleBorder()
  /// Rounded Corner: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
  final ShapeBorder? shapeBorder;

  const FSimpleButton({
    Key? key,
    this.backgroundColor = Colors.transparent,
    this.splashColor = Colors.white,
    this.elevation = 0,
    this.margin,
    this.padding,
    this.child,
    this.onTap,
    this.shapeBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? childView = child;
    if (margin != null || padding != null) {
      childView = Container(
        margin: margin,
        padding: padding,
        child: child,
      );
    }

    Widget view = Card(
      shape: shapeBorder,
      color: backgroundColor,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        child: childView,
      ),
    );

    return view;
  }
}
