/*
 * Copyright (c) 2022.
 * Created by Andy Pangaribuan. All Rights Reserved.
 *
 * This product is protected by copyright and distributed under
 * licenses restricting copying, distribution and decompilation.
 */

part of ff;

abstract class FPageLogic<T> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool canPopPage = true;

  final disposer = FDisposer._();

  late FPage Function() _getPage;

  T get page => _getPage() as T;

  _FPageObject get _po => _getPage()._po;

  BuildContext get context {
    return scaffoldKey.currentContext ?? _po.getObject(GetObjectType.context) as BuildContext;
  }

  Future<bool> onWillPop() async {
    return canPopPage;
  }

  /// called first
  /// context not ready yet when this method called
  @protected
  void initState() {}

  /// called second
  @protected
  void onBuildLayout() {}

  /// called third
  @protected
  void onLayoutLoaded() {}

  void pageBack({Object? result}) {
    ff.func.pageBack(context, result: result);
  }

  Future<X> pageOpen<X>(Widget page, {FPageTransitionType? transitionType}) async {
    return ff.func.pageOpen(context, _getPage(), page, transitionType: transitionType);
  }

  @protected
  void pageOpenAndRemovePrevious(Widget page) {
    ff.func.pageOpenAndRemovePrevious(context, page);
  }

  @protected
  void dismissKeyboard() => context.dismissKeyboard();

  @protected
  void dispose() {}
}
