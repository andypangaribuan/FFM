/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

import 'package:ffm/src/pipe.dart';
import 'package:flutter/widgets.dart';

import 'size_measure.dart';

/// FPipe must be persistent (initialize from FPageLogic)
/// FPipe.holder used to save value "isHaveSize"
class FHorizontalSizeMeasurer {
  final FPipe<double> pipe;
  final double widgetHeight;

  set _isHaveSize(bool value) {
    pipe.holder = value;
  }

  FHorizontalSizeMeasurer({
    required this.pipe,
    this.widgetHeight = 1,
  });

  SingleChildRenderObjectWidget items(void Function(FHorizontalSizeMeasurerItems e) fn) {
    _isHaveSize = false;
    final e = FHorizontalSizeMeasurerItems._();
    fn(e);

    Widget getWidget(List<dynamic> ls) {
      bool isRow = ls[0];
      Widget widget = ls[1];
      if (isRow) {
        widget = Row(mainAxisSize: MainAxisSize.min, children: [widget]);
      }

      return SizedBox(height: widgetHeight, child: widget);
    }

    // Measure size all widget with height = 1
    // Wrap will stack vertically if width not enough
    // Not visible but still take the space of parent
    return FSizeMeasure(
        onChange: (size) {
          _isHaveSize = size.height != -1;
          pipe.update(size.height);
        },
        child: Visibility(
          visible: false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: [for (var item in e._items) getWidget(item)],
          ),
        ));
  }
}

class FHorizontalSizeMeasurerItems {
  final List<List<dynamic>> _items = [];

  FHorizontalSizeMeasurerItems._();

  void add({required bool isRow, required Widget widget}) {
    _items.add([isRow, widget]);
  }
}
