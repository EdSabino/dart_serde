import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:serde_generator/src/helpers/generator_serde.dart';
import 'package:serde_generator/src/helpers/mixins/string_modifiers.dart';

class SerializeElement with StringModifier implements GeneratorSerde {
  SerializeElement(this.caseType);

  List<FieldElement> fields;

  Map<dynamic, dynamic> mapper = {};

  String className;

  final DartObject caseType;

  GeneratorSerde setFields(List<FieldElement> list) {
    fields = list;
    return this;
  }

  String generate(String displayName) {
    StringBuffer serializeScript = StringBuffer();
    className = displayName;
    serializeScript.write('String _toJson($displayName instance) {\n');
    serializeScript.write('  Map<String, dynamic> mapper = <String, dynamic>{\n');
    serializeScript.write(resolveFields());
    serializeScript.write('  };\n');    
    serializeScript.write('  return json.encode(mapper);\n');
    serializeScript.write('}\n\n\n');
    return serializeScript.toString();
  }

  String resolveFields() {
    FieldElement field;
    StringBuffer str = StringBuffer();

    for (field in fields) {
      resolveField(field);
    }

    str.write(resolveNestedToString(mapper));

    return str.toString();
  }

  String resolveNestedToString(Map localMap) {
    StringBuffer str = StringBuffer();

    localMap.forEach((key, value) {
      if (value is String) {
        str.write('    \'$key\': $value,\n');
      } else {
        str.write('    \'$key\': {\n${resolveNestedToString(value)}\n},\n');
      }
    });
    return str.toString();
  }

  void resolveField(FieldElement field) {
    if (field.setter == null) {
      return ;
    }
    List<ElementAnnotation> metadatas = field.metadata;
    if (metadatas == null || metadatas.isEmpty) {
      mapper[getFieldNameCased(field.name.toString(), caseType)] = resolveTypeForField(field);
      return ;
    }
    DartObject obj;
    ElementAnnotation metadata;
    for (metadata in metadatas) {
      obj = metadata.computeConstantValue();
      if (obj.type.toString() == 'Prop') {
        break;
      }
    }
    if (obj.getField('mustSerde').toBoolValue()) {
      if (obj.getField('isNested').toBoolValue()) {
        resolveNestedField(obj, getFieldName(obj, field.name), resolveTypeForField(field, obj));
        return ;
      }
      mapper[getFieldName(obj, field.name)] = resolveTypeForField(field, obj);
    }
  }

  String getFieldName(DartObject obj, String originalName) {
    DartObject fieldName = obj.getField('name');
    if (fieldName.isNull) {
      return originalName;
    }
    return getFieldNameCased(fieldName.toStringValue(), caseType);
  }

  void resolveNestedField(DartObject obj, String fieldName, String name) {
    String actualString;
    Map<dynamic, dynamic> actual = mapper;
    List<String> paths = obj.getField('path').toStringValue().split('.');
    for (actualString in paths) {
      if (actual[actualString] == null) {
        actual[actualString] = {};
      }
      actual = actual[actualString];
    }
    actual[fieldName] = name;
  }

  String resolveTypeForField(FieldElement field, [DartObject obj]) {
    if (obj != null && !obj.getField('serializeFunction').isNull) {
      return withFunction(field, obj.getField('serializeFunction').toFunctionValue());
    }
    String concat = resolveType(field.type);
    return 'instance.${field.name}${concat}';
  }

  String resolveType(DartType type) {
    if (
      type.isDartCoreBool ||
      type.isDartCoreInt ||
      type.isDartCoreNum ||
      type.isDartCoreString ||
      type.isDartCoreDouble ||
      type.displayName == "Duration"
    ) {
      return '.toString()';
    }
    if (type.isDartCoreList) {
      if (type is ParameterizedType) {
        return '.cast<${type.typeArguments[0]}>().toList()';
      }
    }
    if (type.displayName == 'DateTime') {
      return '.toUtc().toIso8601String()';
    }
    return '.toJson()';
  }

  String withFunction(FieldElement field, ExecutableElement function) {
    if (function.isStatic) {
      return '$className.${function.name}(instance.${field.name})';
    }
    print('''
    -----------------------------------------------------------------------
                              Serde Error                               
    ---------------------------------------------------------------------
    The function must be an staticType                                                      
    ---------------------------------------------------------------------
    ''');
    return '';
  }

}