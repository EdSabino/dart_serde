import 'dart:convert';

import 'package:test/test.dart';

import 'mocked.dart';
  

void main() {
  test('check', () {
    Mocked mocked = Mocked();
    // expect(mocked.toJson(), '''{"something":true}''');
    Map<String, dynamic> mapper = {
      'something': 'asdas',
      'mama': {
        'Mia': {
          'mamaMia': 'asdas'
        }
      },
      'mama': {
        'Mia': {
          'meme': 'asdas'
        }
      }
    };
    expect(json.encode(mapper), '');
  });
}
