import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double defaultHeight = 53.0;

  @override
  final Size preferredSize;
  final void Function()? leadingIconOnPressed;
  final void Function()? homeOnPressed;
  final String? title;

  TEAppBar({
    super.key,
    this.leadingIconOnPressed,
    this.title,
    this.homeOnPressed,
    double? height,
  }) : preferredSize = Size.fromHeight(height ?? TEAppBar.defaultHeight);

  List<Widget> _buildActions() {
    if (homeOnPressed == null) return [];
    return [
      TEonTap(
          onTap: homeOnPressed!, child: Center(child: DS.getImage().iconHome)),
      DS.getSpace().hSmall,
    ];
  }

  Widget? _buildTitle(double titleMaxWidth) {
    if (title == null) return null;

    final titleWidth = Container(
      alignment: Alignment.center,
      width: titleMaxWidth,
      child: Text(
        title!,
        overflow: TextOverflow.ellipsis,
        style:
            DS.getTextStyle().paragraph2.copyWith(fontWeight: FontWeight.bold),
      ),
    );
    return titleWidth;
  }

  Widget? _buildLeading() {
    if (leadingIconOnPressed == null) {
      return null;
    } else {
      return IconButton(
          onPressed: leadingIconOnPressed,
          icon: const Icon(Icons.arrow_back_ios));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: DS.getColor().background000,
      surfaceTintColor: DS.getColor().background000,
      leading: _buildLeading(),
      actions: _buildActions(),
      centerTitle: true,
      title: _buildTitle(MediaQuery.of(context).size.width / 1.8),
    );
  }
}
