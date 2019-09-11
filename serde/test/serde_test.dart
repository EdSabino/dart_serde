import 'package:test/test.dart';

import 'package:serde/serde.dart';

void main() {
  test('must serialize and deserialize if not specified', () {
    final Serde serde = Serde();
    expect(serde.deserialize, true);
    expect(serde.serialize, true);
  });

  test('must change the value of deserialize when added', () {
    final Serde serde = Serde(deserialize: false);
    expect(serde.deserialize, false);
    expect(serde.serialize, true);
  });

  test('must change the value of deserialize when added', () {
    final Serde serde = Serde(serialize: false);
    expect(serde.deserialize, true);
    expect(serde.serialize, false);
  });

  test('must change the value of deserialize when added', () {
    final Serde serde = Serde(deserialize: false, serialize: false);
    expect(serde.deserialize, false);
    expect(serde.serialize, false);
  });
}
