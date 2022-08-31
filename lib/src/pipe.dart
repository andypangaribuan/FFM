/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

library ff.pipe;

import 'dart:async';

import 'package:ffm/src/ff.dart';
import 'package:ffm/src/page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

part 'pipe_model.dart';

class FPipe<T> {
  final _pipe = BehaviorSubject<T>();
  BehaviorSubject<FPipeErrModel>? _errPipe;

  late T _lastValue;
  T get value {
    if (textEditingController != null) {
      return textEditingController!.text as T;
    }

    if (_pipe.hasValue) {
      return _pipe.value;
    }
    if (ff.func.isGenericTypeNullable<T>()) {
      return null as T;
    }
    return _pipe.value;
  }

  late T _lastSubscribeValue;

  FPipeErrModel get errValue {
    return _errPipe!.value;
  }

  final _subscriptionListeners = <void Function(T val)>[];
  var subscriptionSkippedCount = 0;
  var _disposed = false;

  TextEditingController? textEditingController;
  StreamSubscription? _eventSubscription;

  FPipe(
      {required T initValue,
      required FDisposer disposer,
      bool withTextEditingController = false,
      bool withErrPipe = false}) {
    disposer.register(dispose);

    _lastValue = initValue;
    _lastSubscribeValue = initValue;
    if (initValue != null) {
      update(initValue);

      if (initValue is String && withTextEditingController) {
        textEditingController = TextEditingController(text: initValue)
          ..addListener(_textEditingControllerListener);
      }
    }

    if (withErrPipe) {
      final model = FPipeErrModel._((value) => errUpdate(value));
      _errPipe = BehaviorSubject<FPipeErrModel>()..sink.add(model);
    }
  }

  void _safePipeSinkAdd(T value) {
    if (_lastValue != value) {
      _lastValue = value;
      _pipe.sink.add(value);
    }
  }

  Widget onUpdate(Widget Function(T val) listener) {
    return _disposed
        ? Container()
        : StreamBuilder<T>(
            stream: _pipe.stream,
            initialData: value,
            builder: (context, snap) => listener(snap.data as T),
          );
  }

  Widget onErrUpdate(Widget Function(FPipeErrModel val) listener) {
    return _disposed
        ? Container()
        : StreamBuilder<FPipeErrModel>(
            stream: _errPipe!.stream,
            initialData: _errPipe!.value,
            builder: (context, snap) => listener(snap.data!),
          );
  }

  void update(T value) {
    if (_disposed) {
      return;
    }

    if (textEditingController == null) {
      _pipe.sink.add(value);
      return;
    }

    if (ff.func.isTypeOf<T, String>()) {
      final text = value as String;
      textEditingController!
        ..text = text
        ..selection = TextSelection.collapsed(offset: text.length);
    }
  }

  void errUpdate(FPipeErrModel value) {
    if (_disposed) {
      return;
    }

    _errPipe!.sink.add(value);
  }

  void softUpdate(T val) {
    if (_disposed) {
      return;
    }

    if (value != val) {
      if (textEditingController == null) {
        update(val);
      } else if (ff.func.isTypeOf<T, String>()) {
        var text = value as String;
        textEditingController!
          ..text = text
          ..selection = TextSelection.collapsed(offset: text.length);

        update(val);
      }
    }
  }

  void subscribe(
      {required void Function(T val) listener, int skippedCount = 0}) {
    if (_disposed) {
      return;
    }

    _subscriptionListeners.add(listener);
    subscriptionSkippedCount = skippedCount < 0 ? 0 : skippedCount;
    _eventSubscription ??= _pipe.listen(_subscriptionEvent);
  }

  void _subscriptionEvent(T value) {
    if (_disposed) {
      return;
    }

    if (_lastSubscribeValue == value) {
      return;
    }
    _lastSubscribeValue = value;

    if (subscriptionSkippedCount > 0) {
      subscriptionSkippedCount--;
    } else {
      for (var listener in _subscriptionListeners) {
        listener(value);
      }
    }
  }

  void _textEditingControllerListener() {
    _safePipeSinkAdd(value);
  }

  void callSubscriber() {
    if (_disposed) {
      return;
    }

    _subscriptionEvent(value);
  }

  void forceCallSubscriber() {
    if (_disposed) {
      return;
    }

    for (var listener in _subscriptionListeners) {
      listener(value);
    }
  }

  @protected
  void dispose() {
    if (!_disposed) {
      _disposed = true;
      _eventSubscription?.cancel();
      textEditingController?.dispose();
      _pipe.close();
      _errPipe?.close();
    }
  }
}
