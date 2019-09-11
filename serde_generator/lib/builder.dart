library serde.builder;

import 'package:build/build.dart';
import 'package:serde_generator/src/serde_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder generateJsonSerializer(BuilderOptions options) => SharedPartBuilder([SerdeGenerator()], 'serde');