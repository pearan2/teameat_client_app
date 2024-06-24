import 'package:flutter/widgets.dart';

class KeepAliveWrap extends StatefulWidget {
  final Widget child;
  const KeepAliveWrap({super.key, required this.child});

  @override
  State<KeepAliveWrap> createState() => _KeepAliveWrapState();
}

class _KeepAliveWrapState extends State<KeepAliveWrap>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
