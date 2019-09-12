import 'dart:convert';

import 'package:serde/serde.dart';

part 'mockedo.g.dart';

@Serde()
class Mockedo {
  Mockedo();
  factory Mockedo.fromJson(Map<String, dynamic> data) => _fromJson(data);
  String toJson() => _toJson(this);

  String something;
}