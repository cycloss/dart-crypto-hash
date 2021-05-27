import 'package:crypto_hash/crypto_hash.dart';
import 'package:test/test.dart';

void main() {
  group('Group 1', () {
    setUp(() {});

    test('Simple test', () {
      var testStr = 'A Test';
      var hash = ShaOne.hashBytes(testStr.codeUnits);
      expect(hash, '8f0c0855915633e4a7de19468b3874c8901df043');
    });

    test('String api test', () {
      var testStr = 'Hello World!';
      var hash = ShaOne.hashString(testStr);
      expect(hash, '2ef7bde68ce5404e97d5f042f95f89f1c232871');
    });

    test('Empty test', () {
      var testStr = '';
      var hash = ShaOne.hashBytes(testStr.codeUnits);
      expect(hash, 'da39a3ee5e6b4b0d3255bfef95601890afd80709');
    });

    test('448 test', () {
      var testStr = 'abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq';
      var hash = ShaOne.hashBytes(testStr.codeUnits);
      expect(hash, '84983e441c3bd26ebaae4aa1f95129e5e54670f1');
    });

    test('896 test', () {
      var testStr =
          'abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu';
      var hash = ShaOne.hashBytes(testStr.codeUnits);
      expect(hash, 'a49b2446a02c645bf419f995b67091253a04a259');
    });

    test('1 mil a test', () {
      var testStr = 'a' * 1000000;
      var hash = ShaOne.hashBytes(testStr.codeUnits);
      expect(hash, '34aa973cd4c4daa4f61eeb2bdbad27316534016f');
    });

    test('If poem test', () {
      var hash = ShaOne.hashFile('test/if.txt');
      expect(hash, '9d3cd5d6e818f277d7b63b86d843410fe6bbda75');
    });

    test('Japanese test', () async {
      var hash = await ShaOne.hashFileAsync('test/boukendeshodesho.txt');
      expect(hash, 'b23ea7fae3b74b97efcda06095c392b09792de2b');
    });

    // this test takes about 20 seconds to compute the hash as the string is 1GB in length
    test('Final boss test', () {
      var testStr =
          'abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmno' *
              16777216;
      var hash = ShaOne.hashBytes(testStr.codeUnits);
      expect(hash, '7789f0c9ef7bfc40d93311143dfbe69e2017f592');
    });
  });
}
