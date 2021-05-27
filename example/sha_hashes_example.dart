import 'dart:convert';
import 'dart:io';

import 'package:crypto_hash/crypto_hash.dart';

void main() {
  var testString = 'Hello World!';
  var hash = ShaOne.hashData(testString.codeUnits);
  print(hash);

  var testString2 = 'こんにちは世界！';
  var hash2 = ShaOne.hashData(utf8.encode(testString2));
  print(hash2); // prints f66b68c765fae864106c7352d06be5df5ab510c3

  var loremFile = File('example/lorem.txt');
  var hash3 = ShaOne.hashData(loremFile.readAsBytesSync());
  print(hash3); // prints 4b0b2b74dab6099447a0471d6b390ce21055d508
}
