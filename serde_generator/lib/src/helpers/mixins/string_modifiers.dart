import 'package:analyzer/dart/constant/value.dart';

mixin StringModifier {
  String getFieldNameCased(String name, DartObject caseType) {
    if (caseType.getField('snake') != null) {
      return name.replaceAllMapped(new RegExp(r'[A-Z]'), (Match match) => '_' + match.group(0).toLowerCase());
    }
    return name;
  }
}