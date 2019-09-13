
import 'dart:convert';

import 'package:serde/serde.dart';

import 'mockedo.dart';

part 'mocked.g.dart';

@Serde()
class Mocked {
  Mocked();

  factory Mocked.fromJson(Map<String, dynamic> data) => _fromJson(data);
  String toJson() => _toJson(this);

  bool something = true;

  @Prop(name: 'mamaMia', isNested: true, path: 'mama.Mia')
  String withMetadata;

  @Prop(name: 'mil', isNested: true, path: 'mama.mia', isNullable: true)
  String meta;

  @Prop(mustSerde: false)
  String noSerde;

  Mockedo mocked2;

  String get value => meta;
}

