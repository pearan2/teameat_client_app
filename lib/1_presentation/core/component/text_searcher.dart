import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/3_domain/core/i_search_history_repository.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/extension/string.dart';

class TextSearchButton<T extends ISearchHistoryRepository>
    extends StatelessWidget {
  final void Function(String) onCompleted;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? value;
  final String? hintText;
  final Widget? label;
  final double padding;

  const TextSearchButton({
    super.key,
    required this.onCompleted,
    this.focusNode,
    this.controller,
    this.value,
    this.hintText,
    this.label,
    this.padding = 2.0,
  });

  void onTap() {
    final repo = Get.find<T>();
    Get.to(
      TextSearchOverlay(
        onCompleted: onCompleted,
        focusNode: focusNode,
        controller: controller,
        value: value,
        hintText: hintText,
        historyRepository: repo,
      ),
      transition: Transition.noTransition,
      duration: Duration.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
        onTap: onTap,
        child: label != null
            ? label!
            : DS.image
                .searchLg(
                    color: value.isEmpty()
                        ? DS.color.background700
                        : defaultButtonActiveColor)
                .paddingAll(padding));
  }
}

class TextSearchOverlay extends StatefulWidget {
  final void Function(String) onCompleted;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? value;
  final String? hintText;
  final ISearchHistoryRepository historyRepository;

  const TextSearchOverlay({
    super.key,
    required this.onCompleted,
    this.focusNode,
    this.controller,
    this.value,
    this.hintText,
    required this.historyRepository,
  });

  @override
  State<TextSearchOverlay> createState() => _TextSearchOverlayState();
}

class _TextSearchOverlayState extends State<TextSearchOverlay> {
  late final histories = widget.historyRepository.findHistories();

  // state
  late List<String> filtered = [...histories];

  void setHistories(List<String> next) {
    setState(() => filtered = next);
  }

  void onCompleted(String searchText) {
    // 비어있지 않을 경우 검색어 저장
    if (searchText.isNotEmpty) {
      widget.historyRepository.memorize(searchText);
    }
    Get.back();
    widget.onCompleted(searchText);
  }

  void onClose() {
    Get.back();
  }

  void onHistoryDelete(String searchText) {
    widget.historyRepository.remove(searchText);
    setHistories(filtered..remove(searchText));
  }

  void onHistoryClean() {
    widget.historyRepository.clean();
    setHistories([]);
  }

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      resizeToAvoidBottomInset: true,
      appBar: TEAppBar(height: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TEonTap(
            onTap: onClose,
            child: SizedBox(
              height: TEAppBar.defaultHeight,
              child: Row(
                children: [
                  Expanded(
                    child: TextSearcher(
                      onCompleted: onCompleted,
                      focusNode: widget.focusNode,
                      controller: widget.controller,
                      value: widget.value,
                      hintText: widget.hintText,
                      autoFocus: true,
                    ),
                  ),
                  DS.space.hTiny,
                  DS.image.closeLg,
                ],
              ),
            ),
          ),
          DS.space.vMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DS.text.recentSearchText,
                  style: DS.textStyle.paragraph2.semiBold.h14),
              TEonTap(
                  onTap: onHistoryClean,
                  child: Text(
                    DS.text.cleanSearchHistory,
                    style: DS.textStyle.caption2.h14.b700
                        .copyWith(decoration: TextDecoration.underline),
                  )),
            ],
          ),
          DS.space.vXBase,
          Wrap(
            spacing: DS.space.xSmall,
            runSpacing: DS.space.xSmall,
            children: filtered
                .map((text) => TEDeletableButton(
                    onTap: () => onCompleted(text),
                    onDelete: () => onHistoryDelete(text),
                    text: text))
                .toList(),
          ),
        ],
      ).withBasePadding,
    );
  }
}

class TextSearcher extends StatefulWidget {
  final void Function(String) onCompleted;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? value;
  final String? hintText;
  final bool autoFocus;
  final void Function(String)? onChanged;
  final bool enabled;

  const TextSearcher(
      {super.key,
      required this.onCompleted,
      this.onChanged,
      this.focusNode,
      this.autoFocus = false,
      this.hintText,
      this.controller,
      this.enabled = true,
      this.value});

  @override
  State<TextSearcher> createState() => _TextSearcherState();
}

class _TextSearcherState extends State<TextSearcher> {
  late final focusNode = widget.focusNode ?? FocusNode();
  late final controller =
      widget.controller ?? TextEditingController(text: widget.value);

  late bool isShowResetButton = controller.text.isNotEmpty;

  void controllerListener() {
    setState(() => isShowResetButton = controller.text.isNotEmpty);
  }

  void init() {
    controller.text = widget.value ?? '';
    controller.addListener(controllerListener);
    if (widget.autoFocus) {
      focusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(covariant TextSearcher oldWidget) {
    if (oldWidget.value != widget.value) {
      init();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(controllerListener);
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      enabled: widget.enabled,
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: () {
        focusNode.unfocus();
        widget.onCompleted(controller.text.trim());
      },
      onChanged: widget.onChanged,
      cursorColor: DS.color.primary600,
      padding: EdgeInsets.all(DS.space.tiny),
      prefix: DS.image.searchSm.paddingOnly(left: DS.space.tiny),
      suffix: isShowResetButton
          ? TEonTap(
              onTap: () {
                controller.text = '';
                widget.onCompleted(controller.text.trim());
              },
              child: DS.image.closeLg.paddingOnly(right: DS.space.tiny))
          : null,
      placeholderStyle: DS.textStyle.caption1.b500,
      placeholder: widget.hintText ?? DS.text.textSearcherPlaceHolder,
      style: DS.textStyle.caption1.b800,
      decoration: BoxDecoration(
        color: DS.color.background100,
        borderRadius: BorderRadius.circular(DS.space.xTiny),
      ),
    );
  }
}
