import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/logger.dart';

import '../injectable/injectable.dart';

abstract class GetItHook<T extends Object> extends StatefulWidget {
  const GetItHook({super.key, T? controller}) : _controller = controller;

  @override
  State<GetItHook<T>> createState() => _GetItHookState<T>();

  void init();

  bool get canDisposeController;

  Widget build(BuildContext context);

  T get controller => _controller ?? getIt<T>();

  final T? _controller;

  void onDispose();

  void _unRegister() {
    try {
      if (canDisposeController && getIt.isRegistered<T>()) {
        getIt.unregister<T>();
      }
    } on Exception catch (e) {
      e.log;
    }
  }
}

class _GetItHookState<T extends Object> extends State<GetItHook<T>> {
  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void initState() {
    super.initState();
    widget.init();
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose();
    widget._unRegister();
  }
}
