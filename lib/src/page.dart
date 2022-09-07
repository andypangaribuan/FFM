/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

library ff;

import 'dart:async';
import 'dart:collection';

import 'package:ffm/src/enum.dart';
import 'package:ffm/src/ff.dart';
import 'package:ffm/src/page_transition.dart';
import 'package:flutter/material.dart';

import 'extensions.dart';

part 'disposer.dart';
part 'page_logic.dart';
part 'page_object.dart';

abstract class FPage<T extends FPageLogic> {
  final _po = _FPageObject<T>._();

  T get logic => _po.logic;

  _FPageState get _state => _po._state!;

  BuildContext get context => logic.context;

  Widget getWidget() {
    if (_po._state == null) {
      return _FYPage((state) {
        _po._state = state;
        return this;
      });
    }

    return _po._state!.widget;
  }

  /// called first
  @protected
  void initialize();

  /// called second
  /// context not ready yet when this method called
  @protected
  void initState() {}

  /// called third
  @protected
  Widget buildLayout(BuildContext context);

  /// called fourth
  @protected
  void onLayoutLoaded() {}

  @protected
  void setLogic(T logic) {
    logic._getPage = () => this;
    _po.logic = logic;
  }

  @protected
  void dispose() {}
}


class _FYPage extends StatefulWidget {
  final _holder = _FYPageHolder();

  _FYPage(FPage Function(_FPageState state) pageStateExchange) {
    _holder.pageStateExchange = pageStateExchange;
  }

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _FPageState(_holder.pageStateExchange);
}

class _FYPageHolder {
  late FPage Function(_FPageState state) pageStateExchange;
  bool calledOnBuildLayoutFirstCall = false;
}


class _FPageState extends State<_FYPage> {
  late FPage page;

  _FPageObject get _po => page._po;

  _FPageState(FPage Function(_FPageState state) pageStateExchange) {
    page = pageStateExchange(this);
    page.initialize();
  }

  @override
  void initState() {
    super.initState();
    page.initState();
    page.logic.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      page.onLayoutLoaded();
      page.logic.onLayoutLoaded();
    });
  }

  @override
  Widget build(BuildContext context) {
    _po._getObjects[GetObjectType.context] = () => context;

    return page.buildLayout(context).also((_) {
      page.logic.onBuildLayout();
      if (!widget._holder.calledOnBuildLayoutFirstCall) {
        widget._holder.calledOnBuildLayoutFirstCall = true;
        page.logic.onBuildLayoutFirstCall();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    page.dispose();
    page.logic.dispose();
    page.logic.disposer._dispose();
  }
}
