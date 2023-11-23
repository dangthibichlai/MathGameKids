// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:template/data/model/response/package_model.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/helper/izi_validate.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';

class SettingsModel {
  String? linkShareIos;
  String? id;
  String? linkShareAndroid;
  List<PackageModel>? priceList;
  String? termsAndService;
  String? privacyPolicy;
  String? image;
  String? transactionPolicy;
  String? logo;
  String? policy;
  int? countQuestionsFree;
  List<String>? aiImages;
  SettingsModel({
    this.linkShareIos,
    this.linkShareAndroid,
    this.id,
    this.priceList,
    this.termsAndService,
    this.privacyPolicy,
    this.image,
    this.transactionPolicy,
    this.logo,
    this.policy,
    this.countQuestionsFree,
    this.aiImages,
  });

  SettingsModel copyWith({
    String? id,
    List<PackageModel>? priceList,
    String? termsAndService,
    String? privacyPolicy,
    String? image,
    String? transactionPolicy,
    String? logo,
    String? policy,
    int? countQuestionsFree,
    List<String>? aiImages,
  }) {
    return SettingsModel(
      id: id ?? this.id,
      priceList: priceList ?? this.priceList,
      termsAndService: termsAndService ?? this.termsAndService,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      image: image ?? this.image,
      transactionPolicy: transactionPolicy ?? this.transactionPolicy,
      logo: logo ?? this.logo,
      countQuestionsFree: countQuestionsFree ?? this.countQuestionsFree,
      policy: policy ?? this.policy,
      aiImages: aiImages ?? this.aiImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(linkShareIos)) 'linkShareIos': linkShareIos,
      if (!IZIValidate.nullOrEmpty(id)) '_id': id,
      if (!IZIValidate.nullOrEmpty(linkShareAndroid))
        'linkShareAndroid': linkShareAndroid,
      // if (!IZIValidate.nullOrEmpty(ilPolicy)) 'ilPolicy': ilPolicy,
      // if (!IZIValidate.nullOrEmpty(appType)) 'appType': appType,
      // if (!IZIValidate.nullOrEmpty(ilTerms)) 'ilTerms': ilTerms,
      // if (!IZIValidate.nullOrEmpty(policy)) 'policy': policy,
      // if (!IZIValidate.nullOrEmpty(ilTermsOfServices)) 'ilTermsOfServices': ilTermsOfServices,
      if (!IZIValidate.nullOrEmpty(image)) 'image': image,
      // if (!IZIValidate.nullOrEmpty(qrCode)) 'qrCode': qrCode,
      if (!IZIValidate.nullOrEmpty(logo)) 'logo': logo,
      // if (!IZIValidate.nullOrEmpty(contentNewVersion)) 'contentNewVersion': contentNewVersion,
      // if (!IZIValidate.nullOrEmpty(iosVersionStore)) 'iosVersionStore': iosVersionStore,
      // if (!IZIValidate.nullOrEmpty(isRequiredNewVersionStore)) 'isRequiredNewVersionStore': isRequiredNewVersionStore,
      // if (!IZIValidate.nullOrEmpty(linkAndroid)) 'linkAndroid': linkAndroid,
      // if (!IZIValidate.nullOrEmpty(linkIos)) 'linkIos': linkIos,
      // if (!IZIValidate.nullOrEmpty(moneyReverse)) 'moneyReverse': moneyReverse,
    };
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'priceList': priceList?.map((x) => x.toMap()).toList(),
  //     'termsAndService': termsAndService,
  //     'privacyPolicy': privacyPolicy,
  //     'image': image,
  //     'transactionPolicy': transactionPolicy,
  //     'logo': logo,
  //     'policy': policy,

  //   };
  // }
  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      linkShareIos:
          map['linkShareIos'] != null ? map['linkShareIos'] as String : null,
      id: map['_id'] != null ? map['_id'] as String : null,
      linkShareAndroid: map['linkShareAndroid'] != null
          ? map['linkShareAndroid'] as String
          : null,
      // ilPolicy: map['ilPolicy'] != null ? map['ilPolicy'] as String : null,
      // appType: map['appType'] != null ? map['appType'] as String : null,
      // ilTerms: map['ilTerms'] != null ? map['ilTerms'] as String : null,
      // policy: map['policy'] != null ? map['policy'] as String : null,
      // ilTermsOfServices: map['ilTermsOfServices'] != null ? map['ilTermsOfServices'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      logo: map['logo'] != null ? map['logo'] as String : null,
      // contentNewVersion: map['contentNewVersion'] != null ? map['contentNewVersion'] as String : null,
      // iosVersionStore: map['iosVersionStore'] != null ? map['iosVersionStore'] as String : null,
      // isRequiredNewVersionStore:
      //     map['isRequiredNewVersionStore'] != null ? map['isRequiredNewVersionStore'] as bool : null,
      // linkAndroid: map['linkAndroid'] != null ? map['linkAndroid'] as String : null,
      // linkIos: map['linkIos'] != null ? map['linkIos'] as String : null,
      // moneyReverse: map['moneyReverse'] != null ? map['moneyReverse'] as int : null,
    );
  }

  // factory SettingsModel.fromMap(Map<String, dynamic> map) {
  //   return SettingsModel(
  //     id: map['id'] != null ? map['id'] as String : null,
  //     priceList: map['priceList'] != null
  //         ? List<PackageModel>.from(
  //             (map['priceList'] as List<dynamic>).map<PackageModel?>(
  //               (x) => PackageModel.fromMap(x as Map<String, dynamic>),
  //             ),
  //           )
  //         : null,
  //     termsAndService: map['termsAndService'] != null
  //         ? !IZIValidate.nullOrEmpty((map['termsAndService'] as Map<String,
  //                 dynamic>)[sl<SharedPreferenceHelper>().getLocale])
  //             ? (map['termsAndService'] as Map<String, dynamic>)[
  //                     sl<SharedPreferenceHelper>().getLocale]
  //                 .toString()
  //             : (map['termsAndService'] as Map<String, dynamic>)['en']
  //                 .toString()
  //         : null,
  //     privacyPolicy: map['privacyPolicy'] != null
  //         ? !IZIValidate.nullOrEmpty((map['privacyPolicy'] as Map<String,
  //                 dynamic>)[sl<SharedPreferenceHelper>().getLocale])
  //             ? (map['privacyPolicy'] as Map<String, dynamic>)[
  //                     sl<SharedPreferenceHelper>().getLocale]
  //                 .toString()
  //             : (map['privacyPolicy'] as Map<String, dynamic>)['en'].toString()
  //         : null,
  //     image: map['image'] != null ? map['image'] as String : null,
  //     transactionPolicy: map['transactionPolicy'] != null
  //         ? map['transactionPolicy'] as String
  //         : null,
  //     logo: map['logo'] != null ? map['logo'] as String : null,
  //     aiImages: map['aiImages'] != null
  //         ? (map['aiImages'] as List<dynamic>).map((e) => e.toString()).toList()
  //         : [],
  //     countQuestionsFree: map['countQuestionsFree'] != null
  //         ? (map['countQuestionsFree'] as num).toInt()
  //         : null,
  //     policy: map['policy'] != null ? map['policy'] as String : null,
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory SettingsModel.fromJson(String source) =>
      SettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SettingsModel(id: $id, priceList: $priceList, termsAndService: $termsAndService, privacyPolicy: $privacyPolicy, image: $image, transactionPolicy: $transactionPolicy, logo: $logo, policy: $policy)';
  }

  @override
  bool operator ==(covariant SettingsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.priceList, priceList) &&
        other.termsAndService == termsAndService &&
        other.privacyPolicy == privacyPolicy &&
        other.image == image &&
        other.transactionPolicy == transactionPolicy &&
        other.logo == logo &&
        other.countQuestionsFree == countQuestionsFree &&
        other.aiImages == aiImages &&
        other.policy == policy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        priceList.hashCode ^
        termsAndService.hashCode ^
        privacyPolicy.hashCode ^
        image.hashCode ^
        transactionPolicy.hashCode ^
        logo.hashCode ^
        countQuestionsFree.hashCode ^
        aiImages.hashCode ^
        policy.hashCode;
  }
}
