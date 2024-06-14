import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/text_searcher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/3_domain/core/i_local_repository.dart';
import 'package:teameat/3_domain/core/local.dart';

Future<Local?> searchLocal() async {
  return showTEDialog<Local>(child: const LocalSearchDialog());
}

class LocalSearchDialog extends StatefulWidget {
  const LocalSearchDialog({super.key});

  @override
  State<LocalSearchDialog> createState() => _LocalSearchDialogState();
}

class _LocalSearchDialogState extends State<LocalSearchDialog> {
  final _localRepo = Get.find<ILocalRepository>();
  final focusNode = FocusNode();
  final textEditController = TextEditingController();

  List<Local> locals = [];
  bool isLoading = false;

  @override
  void dispose() {
    focusNode.dispose();
    textEditController.dispose();
    super.dispose();
  }

  void loading(bool isLoading) {
    setState(() => this.isLoading = isLoading);
  }

  void onSearchTextRefresh() {
    textEditController.text = '';
    focusNode.requestFocus();
  }

  Future<void> onSearch(String searchText) async {
    if (searchText.isEmpty) {
      focusNode.requestFocus();
      return;
    }
    loading(true);
    final ret = await _localRepo.findLocal(searchText);
    loading(false);
    ret.fold((l) => showError(l.desc), (r) => setState(() => locals = r));
  }

  Widget _buildResult() {
    if (isLoading) {
      return _buildLoading();
    }
    if (locals.isEmpty) {
      return _buildNotFound();
    } else {
      return _buildItems();
    }
  }

  Widget _buildNotFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DS.text.localStoreNotFound,
          style: DS.textStyle.paragraph1,
        ),
        DS.space.vBase,
        Text(
          DS.text.searchLocalStoreTip,
          style: DS.textStyle.paragraph2,
          textAlign: TextAlign.center,
        ),
        DS.space.vBase,
        TEPrimaryButton(
          onTap: onSearchTextRefresh,
          text: DS.text.searchAgain,
          fitContentWidth: true,
          contentHorizontalPadding: DS.space.small,
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: TELoading(),
    );
  }

  Widget _buildItems() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: DS.space.small),
      shrinkWrap: true,
      itemBuilder: (_, idx) {
        if (idx < locals.length) {
          return _buildItem(locals[idx]);
        } else {
          return TEPrimaryButton(
            onTap: onSearchTextRefresh,
            text: DS.text.searchAgain,
            fitContentWidth: true,
            contentHorizontalPadding: DS.space.small,
          );
        }
      },
      separatorBuilder: (_, __) => DS.space.vTiny,
      itemCount: locals.length + 1,
    );
  }

  Widget _buildItem(Local local) {
    return TEonTap(
      onTap: () => Get.back(result: local),
      child: Container(
        padding: EdgeInsets.all(DS.space.tiny),
        decoration: BoxDecoration(
            border: Border.all(color: DS.color.background400),
            borderRadius: BorderRadius.circular(DS.space.xTiny)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  local.title,
                  style: DS.textStyle.paragraph3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DS.space.hTiny,
                Expanded(
                  child: Text(
                    '(${local.category + local.category})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: DS.textStyle.caption1,
                  ),
                ),
              ],
            ),
            DS.space.vXTiny,
            Text(local.address, style: DS.textStyle.caption1),
            DS.space.vXTiny,
            Text(local.roadAddress, style: DS.textStyle.caption1),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextSearcher(
            onCompleted: onSearch,
            focusNode: focusNode,
            controller: textEditController,
            hintText: DS.text.pleaseSearchLocalStore,
            autoFocus: true,
          ),
          Expanded(child: _buildResult())
        ],
      ),
    );
  }
}
