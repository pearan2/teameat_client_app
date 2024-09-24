import 'dart:io';

import 'package:teameat/3_domain/core/local.dart';

class CurationCreate {
  final List<File> menuImages;
  final List<File> storeImages;
  final Local? local;
  final String menuName;
  final String menuPrice;
  final String menuOneLineIntroduce;
  final String menuIntroduce;

  CurationCreate({
    required this.menuImages,
    required this.storeImages,
    this.local,
    required this.menuName,
    required this.menuPrice,
    required this.menuOneLineIntroduce,
    required this.menuIntroduce,
  });

  bool get isEmpty {
    return (menuImages.isEmpty) &&
        (storeImages.isEmpty) &&
        (local == null) &&
        (menuName.isEmpty) &&
        (menuPrice.isEmpty) &&
        (menuOneLineIntroduce.isEmpty) &&
        (menuIntroduce.isEmpty);
  }

  factory CurationCreate.empty() {
    return CurationCreate(
      menuImages: [],
      storeImages: [],
      menuName: '',
      menuPrice: '',
      menuOneLineIntroduce: '',
      menuIntroduce: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuImages': menuImages.map((mi) => mi.path).toList(),
      'storeImages': storeImages.map((si) => si.path).toList(),
      'local': local?.toJson(),
      'menuName': menuName,
      'menuPrice': menuPrice,
      'menuOneLineIntroduce': menuOneLineIntroduce,
      'menuIntroduce': menuIntroduce,
    };
  }

  factory CurationCreate.fromJson(Map<String, dynamic> json) {
    return CurationCreate(
      menuImages: (json['menuImages'] as Iterable).map((p) => File(p)).toList(),
      storeImages:
          (json['storeImages'] as Iterable).map((p) => File(p)).toList(),
      local: json['local'] == null ? null : Local.fromJson(json['local']),
      menuName: json['menuName'],
      menuPrice: json['menuPrice'],
      menuOneLineIntroduce: json['menuOneLineIntroduce'],
      menuIntroduce: json['menuIntroduce'],
    );
  }
}

abstract class ICurationTempSaveService {
  CurationCreate findTempSave();
  Future<bool> tempSave(CurationCreate curationCreate);
  Future<bool> clear();
  bool isTempSaveExists();
}
