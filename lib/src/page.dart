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
import 'package:flutter/material.dart';

import 'extensions.dart';

part 'disposer.dart';
part 'page_logic.dart';
part 'page_object.dart';

abstract class FPage<T extends FPageLogic> extends StatefulWidget {
  final _po = _FPageObject<T>._();

  T get logic => _po.logic;

  BuildContext get context => logic.context;

  FPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FPageState();

  /// called first
  /// context not ready yet when this method called
  @protected
  void initState() {}

  /// called second
  @protected
  Widget buildLayout(BuildContext context);

  /// called third
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

class _FPageState extends State<FPage> {
  FPage get page => widget;

  _FPageObject get _po => page._po;

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
