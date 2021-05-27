import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto_hash/crypto_hash.dart';

void main() {
  var testString = 'Hello World!';
  var hash = ShaOne.hashString(testString);
  print(hash);

  var testString2 = 'こんにちは世界！';
  var bytes = Uint8List.fromList(utf8.encode(testString2));
  var hash2 = ShaOne.hashBytes(bytes);
  print(hash2); // prints f66b68c765fae864106c7352d06be5df5ab510c3

  var hash3 = ShaOne.hashFile('example/lorem.txt');
  print(hash3); // prints 4b0b2b74dab6099447a0471d6b390ce21055d508
}
