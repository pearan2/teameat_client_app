import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double defaultHeight = 53.0;
  @override
  final Size preferredSize = const Size.fromHeight(defaultHeight);
  final void Function() leadingIconOnPressed;
  final String? title;

  const TEAppBar({super.key, required this.leadingIconOnPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: DS.getColor().background000,
      surfaceTintColor: DS.getColor().background000,
      leading: IconButton(
          onPressed: leadingIconOnPressed,
          icon: const Icon(Icons.arrow_back_ios)),
      centerTitle: true,
      title: title == null
          ? null
          : Text(
              title!,
              style: DS
                  .getTextStyle()
                  .paragraph2
                  .copyWith(fontWeight: FontWeight.bold),
            ),
    );
  }
}
// IconButton(
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//         onPressed: leadingIconOnPressed,
//         icon: leadingIcon == null
//             ? SvgPicture.asset(
//                 leadingIconPath,
//                 color: leadingIconColor,
//                 width: 18,
//                 height: 18,
//               )
//             : leadingIcon!,
//       ),