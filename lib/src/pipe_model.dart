/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of ff.pipe;

class FPipeErrModel {
  bool isError = false;
  String? message;
  Object? _object;

  T value<T>() {
    return _object as T;
  }

  void set(Object object) {
    _object = object;
  }
}
