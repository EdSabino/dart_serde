import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';
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

  DartObject getAnnotation(List<ElementAnnotation> metadatas, String type) {
    DartObject obj;
    ElementAnnotation metadata;
    for (metadata in metadatas) {
      obj = metadata.computeConstantValue();
      if (obj.type.toString() == type) {
        return obj;
      }
    }
    return null;
  }

  String basicEndLine(FieldElement field, String variable) {
    String expression = resolveType('[\'${field.name}\']', field.type);
    return createBaseLine(variable, field.name, expression);
  }

  String resolveField(FieldElement field, String variable) {
    List<ElementAnnotation> metadatas = field.metadata;
    if (metadatas == null || metadatas.isEmpty) {
      return basicEndLine(field, variable);
    }
    DartObject obj = getAnnotation(metadatas, 'Prop');
    if (obj == null) {
      return basicEndLine(field, variable);
    }
    if (obj.getField('mustSerde').toBoolValue()) {
      String path = getFieldNamePath(obj, field.name);
      String expression = resolveType(path, field.type);
      return createBaseLine(variable, field.name, expression, obj, path);
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

  String createBaseLine(String variable, String name, String expression, [DartObject obj = null, String path]) {
    if (obj !=  null) {
      if (obj.getField('isNullable').toBoolValue()) {
        return '    $variable.$name = (data$path != null) ? ($expression) : null;\n';
      }
    }
    return '    $variable.$name = $expression;\n';
  }

  String resolveType(String path, DartType type) {
    if (
      type.isDartCoreBool ||
      type.isDartCoreInt ||
      type.isDartCoreNum ||
      type.isDartCoreString
    ) {
      return 'data$path as ${type.toString()}';
    }
    if (type.isDartCoreDouble) {
      return '(data$path as num).toDouble()';
    }
    if (type.isDartCoreList) {
      if (type is ParameterizedType) {
        return 'data$path.map<${type.typeArguments[0]}>((dynamic data) { return ${resolveType('', type.typeArguments[0])}; }).toList()';
      }
    }
    if (type.isDartCoreMap) {
      if (type is ParameterizedType) {
        return 'data$path as ${type.toString()}<${type.typeArguments[0]}, ${type.typeArguments[1]}>';
      }
    }
    Element element = type.element;
    if (element is ClassElement) {
      DartObject obj = getAnnotation(element.metadata, 'Serde');
      if (obj != null) {
        return '${type.toString()}.fromJson(data$path as Map<String, dynamic>)';
      }
      print('''
      -----------------------------------------------------------------------
                                Serde Error                               
      ---------------------------------------------------------------------
      Error on trying to parse the field with type $type, please annotate 
      the field @Prop(mustSerde: false), or add annotation @Serde to      
      class $type                                                         
      ---------------------------------------------------------------------
      ''');
    }
    return 'data$path as ${type.toString()}';
  }
}