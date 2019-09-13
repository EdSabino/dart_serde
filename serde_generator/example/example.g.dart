// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// SerdeGenerator
// **************************************************************************

String _toJson(ExampleClass instance) {
  Map<String, dynamic> mapper = <String, dynamic>{
    'attr1': instance.attr1.toString(),
  };
  return json.encode(mapper);
}

ExampleClass _fromJson(Map<String, dynamic> data) {
  final ExampleClass exampleclass = ExampleClass();
  exampleclass.attr1 = data['attr1'] as bool;
  return exampleclass;
}
