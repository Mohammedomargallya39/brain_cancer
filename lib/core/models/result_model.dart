import 'package:flutter/material.dart';

class ResultModel {
  String? result;

  ResultModel({this.result});

  ResultModel.fromJson(Map<String, dynamic> json) {
    result = json['The Result is'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['The Result is'] = result;
    debugPrint("result is ==>$result");
    return data;
  }
}