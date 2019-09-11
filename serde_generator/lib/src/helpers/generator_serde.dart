import 'package:analyzer/dart/element/element.dart';

abstract class GeneratorSerde {

  String generate(String displayName);

  GeneratorSerde setFields(List<FieldElement> list) ;
}