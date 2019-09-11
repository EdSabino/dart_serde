import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:serde_generator/src/helpers/generator_serde.dart';

class DeserializeElement implements GeneratorSerde {
  DeserializeElement();

  List<FieldElement> fields;


  GeneratorSerde setFields(List<FieldElement> list) {
    fields = list;
    return this;
  }

  String generate(String displayName) {
    StringBuffer serializeScript = StringBuffer();
    final String variable = displayName.toLowerCase();
    FieldElement field;

    serializeScript.write('$displayName _fromJson(Map<String, dynamic> data) {\n');
    serializeScript.write('  final $displayName $variable = $displayName();\n');
    for (field in fields) {
      serializeScript.write(resolveField(field, variable));
    }
    serializeScript.write('return $variable;\n');
    serializeScript.write('}\n');
    return serializeScript.toString();
  }

  String resolveField(FieldElement field, String variable) {
    List<ElementAnnotation> metadatas = field.metadata;
    if (metadatas == null || metadatas.isEmpty) {
      return '    $variable.${field.name} = data[\'${field.name}\'] as ${field.type};\n';
    }
    DartObject obj;
    ElementAnnotation metadata;
    for (metadata in metadatas) {
       obj = metadata.constantValue;
      if (obj.type.toString() == 'Prop') {
        break;
      }
    }
    if (obj.getField('mustSerde').toBoolValue()) {
      return '    $variable.${field.name} = data${getFieldNamePath(obj, field.name)} as ${field.type};\n';
    }
    return '';
  }

  String getFieldNamePath(DartObject obj, String name) {
    String fieldName = getFieldName(obj, name);
    if (obj.getField('isNested').toBoolValue()) {
      return resolveNestedField(obj, fieldName);
    }
    return '[\'$fieldName\']';
  }

  String getFieldName(DartObject obj, String originalName) {
    DartObject fieldName = obj.getField('name');
    if (fieldName.isNull) {
      return originalName;
    }
    return fieldName.toStringValue();
  }

  String resolveNestedField(DartObject obj, String fieldName) {
    String actual;
    List<String> paths = obj.getField('path').toStringValue().split('.');
    StringBuffer generated = StringBuffer();
    for (actual in paths) {
      generated.write('[\'$actual\']');
    }
    generated.write('[\'$fieldName\']');
    return generated.toString();
  }
}