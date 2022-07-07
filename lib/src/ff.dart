/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

library f_guide;

import 'package:flutter/material.dart';

final ff = _FF._();

class _FF {
  _FF._();

  final func = _Func._();
}

//region Func
class _Func {
  _Func._();

  Future<T?> pageOpen<T>(BuildContext context, Widget page) async {
    var val = await Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    return val as T?;
  }

  void pageBack(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }

  void pageOpenAndRemovePrevious(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => page), ModalRoute.withName(''));
  }
}
//endregion
