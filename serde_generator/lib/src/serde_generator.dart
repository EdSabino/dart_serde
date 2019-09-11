import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:serde_generator/src/helpers/deserialize_element.dart';
import 'package:serde_generator/src/helpers/serialize_element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:serde/serde.dart';

class SerdeGenerator extends GeneratorForAnnotation<Serde> {
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      final name = element.name;
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the JsonSerializable annotation from `$name`.',
          element: element);
    }
    final ClassElement classElement = element;
    final DartObject obj = annotation.objectValue;
    return StringCreator(deserialize: obj.getField('deserialize').toBoolValue(), serialize: obj.getField('serialize').toBoolValue()).generateFile(classElement);
  }
}

class StringCreator {
  StringCreator({this.deserialize, this.serialize});

  final bool serialize;
  final bool deserialize;

  String generateFile(ClassElement classElement) {
    StringBuffer generated = StringBuffer();
    if (serialize) {
      generated.write(SerializeElement().setFields(classElement.fields).generate(classElement.displayName));
    }
    if (deserialize) {
      generated.write(DeserializeElement().setFields(classElement.fields).generate(classElement.displayName));
    }

    return generated.toString();
  }
}
