import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:serde_generator/src/helpers/generator_serde.dart';

class SerializeElement implements GeneratorSerde {
  SerializeElement();

  List<FieldElement> fields;

  GeneratorSerde setFields(List<FieldElement> list) {
    fields = list;
    return this;
  }

  String generate(String displayName) {
    StringBuffer serializeScript = StringBuffer();
    FieldElement field;
    serializeScript.write('String _toJson($displayName instance) {\n');
    serializeScript.write('  Map<String, dynamic> mapper = {\n');
    for (field in fields) {
      serializeScript.write(resolveField(field));
    }
    serializeScript.write('  };\n');    
    serializeScript.write('  return json.encode(mapper);\n');
    serializeScript.write('}\n\n\n');
    return serializeScript.toString();
  }

  String resolveField(FieldElement field) {
    List<ElementAnnotation> metadatas = field.metadata;
    if (metadatas == null || metadatas.isEmpty) {
      return createBaseLine(field.name, 'instance.${field.name}');
    }
    DartObject obj;
    ElementAnnotation metadata;
    for (metadata in metadatas) {
       obj = metadata.constantValue;
      if (obj.type.toString() == 'Prop') {
        break;
      }
    }
    if (obj.getField('isNested').toBoolValue()) {
      return resolveNestedField(obj, getFieldName(obj, field.name), field.name);
    }
    return createBaseLine(getFieldName(obj, field.name), 'instance.${field.name}');
  }

  String getFieldName(DartObject obj, String originalName) {
    DartObject fieldName = obj.getField('name');
    if (fieldName.isNull) {
      return originalName;
    }
    return fieldName.toStringValue();
  }

  String resolveNestedField(DartObject obj, String fieldName, String name) {
    String actual;
    List<String> paths = obj.getField('path').toStringValue().split('.');
    StringBuffer generated = StringBuffer();
    for (actual in paths) {
      generated.write('    \'$actual\': {\n');
    }
    String braces = '}' * paths.length;
    generated.write(createBaseLine(fieldName, 'instance.$name'));
    generated.write('    $braces\n,');
    return generated.toString();
  }

  String createBaseLine(String name, String value) {
    return '    \'$name\': $value,\n';
  }
}