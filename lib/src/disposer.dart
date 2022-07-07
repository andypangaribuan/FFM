/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of ff;

class FDisposer {
  final _funcs = <void Function()>[];

  FDisposer._();

  void register(void Function() fn) {
    _funcs.add(fn);
  }

  void _dispose() {
    for (var fn in _funcs) {
      fn();
    }
    _funcs.clear();
  }
}
