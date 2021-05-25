import 'package:crypto_hash/crypto_hash.dart';

void main() {
  var sha1 = ShaOne();
  var testString = 'Hello World!';
  var hash = sha1.hashData(testString.codeUnits);
  print(hash);
}
