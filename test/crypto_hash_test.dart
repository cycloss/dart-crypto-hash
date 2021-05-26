import 'package:crypto_hash/crypto_hash.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {});

    test('First Test', () {
      var testStr = 'A Test';
      var hash = ShaOne.hashData(testStr.codeUnits);
      expect(hash, '8f0c0855915633e4a7de19468b3874c8901df043');
    });
  });
}
