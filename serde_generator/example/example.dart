// Remember, all this, will only work if you are using the complete dart_serde package,this package only contains the annotations

import 'dart:convert';

import 'package:serde/src/serde.dart';
part 'example.g.dart';

@Serde()
class ExampleClass {
  bool attr1;
}

// Just from the annotations the code that will be generated is something like

ExampleClass _fromJson(Map<String, dynamic> data) {
  ExampleClass exampleClass = ExampleClass();
  exampleClass.attr1 = data['attr1'] as bool;
  return exampleClass;
}

String _toJson(ExampleClass instance) {
  Map<String, dynamic> mapper = {
    'attr1': instance.attr1.toString()
  };
  return json.encode(mapper);
}

// Then you have to add to your class
// factory ExampleClass.fromJson(Map<String, dynamic> data) => _fromJson(data);
//  and for serialize toJson(ExampleClass instance) => _toJson(instance);

// You can also add @Prop annotation to an field, if you want to change-it