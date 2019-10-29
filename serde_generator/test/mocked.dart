
import 'dart:convert';

import 'package:serde/serde.dart';

import 'mockedo.dart';

part 'mocked.g.dart';

@Serde(caseType: CaseType.snake)
class Mocked {
  Mocked();

  factory Mocked.fromJson(Map<String, dynamic> data) {
    Mocked mocked = _fromJson(data);
  }
  String toJson() => _toJson(this);

  bool someThing = true;

  @Prop(name: 'mamaMia', isNested: true, path: 'mama.Mia')
  String withMetadata;

  Map<String, dynamic> path;

  @Prop(name: 'mil', isNested: true, path: 'mama.mia', isNullable: true)
  String meta;

  @Prop(mustSerde: false)
  String noSerde;

  List<Mockedo> mocked2;

  DateTime somet;

  @Prop(deserializeFunction: deserializeFunction1)
  Duration lala;

  String get value => meta;

  static String serializeFunction1(dynamic data) => data.inHours.toString();

  static dynamic deserializeFunction1(String data) => Duration(seconds: data as int);
}

