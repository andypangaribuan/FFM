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
  final Function(FPipeErrModel value) _doUpdate;

  FPipeErrModel._(this._doUpdate);

  T object<T>() {
    return _object as T;
  }

  void setError(String message, {Object? object}) {
    isError = true;
    this.message = message;
    _object = object;
  }

  void update() {
    _doUpdate(this);
  }
}
