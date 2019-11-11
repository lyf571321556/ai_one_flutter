import 'package:flutter/material.dart';

enum ListAction { RefreshAction, LoadAction }

abstract class BlocListBase {
  Future getData({Map params});

  Future onRefresh({Map params});

  Future onLoadMore({Map params});

  void dispose();
}

class BlocListProviderWidget<T extends BlocListBase> extends StatefulWidget {
  BlocListProviderWidget({
    Key key,
    @required this.child,
    @required this.bloc,
    this.userDispose: true,
  }) : super(key: key);

  final T bloc;
  final Widget child;
  final bool userDispose;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocListBase>(BuildContext context) {
    final type = _typeOf<BlocListProviderWidget<T>>();
    BlocListProviderWidget<T> provider =
        context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T>
    extends State<BlocListProviderWidget<BlocListBase>> {
  @override
  void dispose() {
    if (widget.userDispose) widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
