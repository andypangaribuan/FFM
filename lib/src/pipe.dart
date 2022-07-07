/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

import 'dart:async';

import 'package:ffm/src/page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class FPipe<T> {
  final _pipe = BehaviorSubject<T>();
  Function(T) get update => _pipe.sink.add;
  T get value => _pipe.value;

  final _subscriptionListeners = <void Function(T val)>[];
  var subscriptionSkippedCount = 0;
  var _disposed = false;

  TextEditingController? textEditingController;
  StreamSubscription? _eventSubscription;

  FPipe({T? initValue, bool withTextEditingController = false, required FDisposer disposer}) {
    disposer.register(dispose);
    if (initValue != null) {
      update(initValue);

      if (initValue is String && withTextEditingController) {
        textEditingController = TextEditingController(text: initValue);
      }
    }
  }

  Widget onUpdate(Widget Function(T? val) listener) {
    if (_disposed) {
      return Container();
    }

    return StreamBuilder<T>(
      stream: _pipe.stream,
      initialData: value,
      builder: (context, snap) => listener(snap.data),
    );
  }

  void subscribe({required void Function(T val) listener, int skippedCount = 0}) {
    if (_disposed) {
      return;
    }

    _subscriptionListeners.add(listener);
    _eventSubscription ??= _pipe.listen(_subscriptionEvent);
  }

  void _subscriptionEvent(T value) {
    if (_disposed) {
      return;
    }

    if (subscriptionSkippedCount > 0) {
      subscriptionSkippedCount--;
    } else {
      for (var listener in _subscriptionListeners) {
        listener(value);
      }
    }
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
    }
  }
}
