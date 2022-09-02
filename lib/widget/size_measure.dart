/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class FSizeMeasure extends SingleChildRenderObjectWidget {
  final void Function(Size size) onChange;

  const FSizeMeasure({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _FSizeMeasureRenderObject(onChange);
  }
}

class _FSizeMeasureRenderObject extends RenderProxyBox {
  Size? oldSize;
  final void Function(Size size) onChange;

  _FSizeMeasureRenderObject(this.onChange);

  @override
  void performLayout() {
    onChange(const Size(-1, -1));
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) {
      onChange(newSize);
      return;
    }

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}
