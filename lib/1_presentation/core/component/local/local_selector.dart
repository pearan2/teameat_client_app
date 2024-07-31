import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/component/local_search_dialog.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/3_domain/core/local.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';

class TELocalSelector extends StatefulWidget {
  final Local? selected;
  final void Function(Local) onSelected;

  const TELocalSelector({
    super.key,
    this.selected,
    required this.onSelected,
  });

  @override
  State<TELocalSelector> createState() => _TELocalSelectorState();
}

class _TELocalSelectorState extends State<TELocalSelector> {
  late final textController =
      TECupertinoTextFieldController(text: widget.selected?.title);
  late bool isEntered = false;

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      searchLocalIsEntered(widget.selected!);
    }
  }

  @override
  void didUpdateWidget(covariant TELocalSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      onLocalChanged(widget.selected);
    }
  }

  void onLocalChanged(Local? newLocal) {
    textController.text = newLocal?.title ?? '';
    if (newLocal == null) {
      setState(() => isEntered = false);
      return;
    }
    widget.onSelected(newLocal);
    searchLocalIsEntered(newLocal);
  }

  Future<void> searchLocalIsEntered(Local local) async {
    final ret =
        await Get.find<IStoreRepository>().isStoreEntered(local.storeId);
    ret.fold((l) => showError(l.desc), (r) => setState(() => isEntered = r));
  }

  Future<void> onTap() async {
    final selected = await searchLocal();
    if (selected == null) return;

    onLocalChanged(selected);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TEonTap(
          onTap: onTap,
          child: TECupertinoTextField(
            isEssential: true,
            autoFocus: false,
            helperText: DS.text.store,
            hintText: DS.text.pleaseSearchLocalStore,
            maxLines: null,
            enabled: false,
            controller: textController,
          ),
        ),
        _IsStoreEnteredText(isEntered: isEntered),
      ],
    );
  }
}

class _IsStoreEnteredText extends StatelessWidget {
  final bool? isEntered;
  const _IsStoreEnteredText({required this.isEntered});

  @override
  Widget build(BuildContext context) {
    if (isEntered == null) {
      return const SizedBox();
    }

    if (isEntered!) {
      return Text(
        DS.text.storeIsEnteredText,
        style: DS.textStyle.caption1.copyWith(color: DS.color.background700),
      );
    } else {
      return const SizedBox();
    }
  }
}
