import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';

class AliMultiPhotoPicker extends StatefulWidget {
  final Widget loading;
  final Widget noPermission;
  final int thumbnailImageSize;
  final void Function(List<File> files) photoSelectHandler;
  final int? limit;
  const AliMultiPhotoPicker({
    super.key,
    this.loading = const Text('loading...'),
    this.noPermission = const Text('앨범 접근 권한을 확인해주세요.'),
    this.limit = 1,
    this.thumbnailImageSize = 480,
    required this.photoSelectHandler,
  });

  @override
  State<AliMultiPhotoPicker> createState() => _AliMultiPhotoPickerState();
}

class _AliMultiPhotoPickerState extends State<AliMultiPhotoPicker> {
  late List<AssetPathEntity> albums;

  late List<AssetEntity> media;
  late Map<int, Uint8List?> memories;
  late Set<int> selectedIndexs;
  late bool isLoading;
  late bool isAuth;

  Future<void> _loadAlbums() async {
    final permissionResult = await PhotoManager.requestPermissionExtend(
      requestOption: const PermissionRequestOption(
        androidPermission: AndroidPermission(
          type: RequestType.image,
          mediaLocation: false,
        ),
      ),
    );
    setState(() => isAuth = permissionResult.isAuth);
    if (isAuth) {
      setState(() => isLoading = true);
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );
      if (albums.isEmpty) {
        showError('권한을 다시 확인해주세요.');
      } else {
        await _loadMedia();
      }
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadMedia() async {
    /// 단계 별로 loading text 수정 할것.
    setState(() => isLoading = true);
    final end = await albums[0].assetCountAsync;
    if (end == 0) {
      media = [];
    } else {
      media = await albums[0].getAssetListRange(start: 0, end: end);
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    isLoading = true;
    isAuth = true;
    media = [];
    memories = {};
    selectedIndexs = {};
    _loadAlbums();
    super.initState();
  }

  void imageClickHandler(int idx) {
    if (selectedIndexs.contains(idx)) {
      setState(() => selectedIndexs = {...selectedIndexs}..remove(idx));
    } else {
      if (widget.limit != null && selectedIndexs.length >= widget.limit!) {
        return;
      }
      setState(() => selectedIndexs = {...selectedIndexs}..add(idx));
    }
  }

  Future<void> finish() async {
    final selectedMedia = <AssetEntity>[];
    for (final idx in selectedIndexs) {
      selectedMedia.add(media[idx]);
    }
    final tempFiles = await Future.wait(selectedMedia.map((m) => m.file));
    final files = <File>[];
    for (final tFile in tempFiles) {
      if (tFile != null) files.add(tFile);
    }
    widget.photoSelectHandler(files);
  }

  Color _getColor(int idx) {
    if (idx.isEven) {
      return const Color(0xFFD7D1D0);
    } else {
      return const Color(0xFFF3EFEE);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuth) return Center(child: widget.noPermission);
    if (isLoading) return Center(child: widget.loading);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          _buildControls(),
          Expanded(child: _buildGrid()),
        ],
      ),
    );
  }

  String _getSelectedIndexLabel() {
    String ret = '${selectedIndexs.length}개 선택 됨';
    if (widget.limit != null) {
      ret += ' (최대 ${widget.limit}개)';
    }
    return ret;
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(_getSelectedIndexLabel(), style: DS.textStyle.paragraph3),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: finish,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('완료', style: DS.textStyle.paragraph3),
          ),
        ),
      ],
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (_, idx) {
        if (widget.limit == 1 && idx == 0) {
          return PhotoFromCameraButton(
            onTap: (file) => widget.photoSelectHandler([file]),
            backgroundColor: _getColor(idx),
          );
        }
        final index = widget.limit == 1 ? idx - 1 : idx;
        if (memories[index] == null) {
          return FutureBuilder<Uint8List?>(
            future: media[index].thumbnailDataWithSize(ThumbnailSize(
                widget.thumbnailImageSize, widget.thumbnailImageSize)),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                memories[index] = snapshot.data!;
                return _buildItem(snapshot.data!, index);
              }
              return PhotoLoadingIndicator(backgroundColor: _getColor(index));
            },
          );
        } else {
          return _buildItem(memories[index]!, index);
        }
      },
      itemCount: media.length,
    );
  }

  Widget _buildItem(Uint8List memory, int idx) {
    if (selectedIndexs.contains(idx)) {
      return Container(
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF143CDF),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: _buildImageButton(memory, idx),
        ),
      );
    } else {
      return _buildImageButton(memory, idx);
    }
  }

  Widget _buildImageButton(Uint8List memory, int idx) {
    return GestureDetector(
      onTap: () => imageClickHandler(idx),
      child: Image.memory(
        memory,
        fit: BoxFit.cover,
      ),
    );
  }
}

Future<List<File>?> showMultiPhotoPickerBottomSheet({int? limit}) async {
  return Get.bottomSheet<List<File>>(
    Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.white,
      ),
      constraints: BoxConstraints(maxHeight: Get.mediaQuery.size.height / 2),
      child: AliMultiPhotoPicker(
        loading: const TELoading(),
        limit: limit,
        photoSelectHandler: (files) {
          Get.back<List<File>>(result: files, closeOverlays: false);
        },
      ),
    ),
  );
}

class PhotoLoadingIndicator extends StatelessWidget {
  final Color backgroundColor;
  const PhotoLoadingIndicator({
    super.key,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: const Center(child: TELoading()),
    );
  }
}

class PhotoFromCameraButton extends StatelessWidget {
  final Color backgroundColor;
  final void Function(File file) onTap;

  const PhotoFromCameraButton(
      {super.key, required this.onTap, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () async {
        // ignore: invalid_use_of_visible_for_testing_member
        final pickedFile = await ImagePicker.platform.getImageFromSource(
          source: ImageSource.camera,
        );
        if (pickedFile != null) {
          final file = File(pickedFile.path);
          onTap(file);
        }
      },
      child: Container(
        color: backgroundColor,
        child: const Center(
          child: Icon(Icons.camera_alt_sharp),
        ),
      ),
    );
  }
}
