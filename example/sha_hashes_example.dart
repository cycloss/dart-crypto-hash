import 'dart:convert';

import 'package:crypto_hash/crypto_hash.dart';

void main() {
  var sha1 = ShaOne();
  var testString = 'Hello World!';
  var hash = sha1.hashData(testString.codeUnits);
  print(hash);

  var testString2 = 'こんにちは世界！';
  var hash2 = sha1.hashData(utf8.encode(testString2));
  print(hash2); // printsf66b68c765fae864106c7352d06be5df5ab510c3
}
