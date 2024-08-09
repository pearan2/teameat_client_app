import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEExpandable extends StatefulWidget {
  final double spaceHeaderAndContent;

  final Widget header;
  final Widget content;

  final bool isExpanded;

  const TEExpandable({
    super.key,
    this.spaceHeaderAndContent = 8,
    this.isExpanded = false,
    required this.header,
    required this.content,
  });

  @override
  State<TEExpandable> createState() => _TEExpandableState();
}

class _TEExpandableState extends State<TEExpandable> {
  late bool isExpanded = widget.isExpanded;

  late final controller =
      ExpandableController(initialExpanded: widget.isExpanded);

  void expandListener() {
    setState(() {
      if (!mounted) {
        return;
      }
      isExpanded = controller.expanded;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(expandListener);
  }

  @override
  void dispose() {
    controller.removeListener(expandListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(splashColor: Colors.transparent),
      child: ExpandableNotifier(
        controller: controller,
        child: ScrollOnExpand(
          scrollOnCollapse: false,
          child: ExpandablePanel(
            controller: controller,
            theme: const ExpandableThemeData(
              hasIcon: false,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
            ),
            header: Row(
              children: [
                Flexible(child: widget.header),
                DS.space.hXXTiny,
                isExpanded ? DS.image.upArrow : DS.image.downArrow,
              ],
            ),
            collapsed: const SizedBox(),
            expanded: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
