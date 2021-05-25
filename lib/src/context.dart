import 'package:crypto_hash/src/constants.dart';

/// The sink where the hash digest is held
class Sha1Context {
  // initialisation constants as defined in paper: https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.180-4.pdf
  int a = 0x67452301;
  int b = 0xefcdab89;
  int c = 0x98badcfe;
  int d = 0x10325476;
  int e = 0xc3d2e1f0;

  String getHash() {
    var hexCodes = [a, b, c, d, e].map((i) => i.toRadixString(16));
    return hexCodes.join();
  }

  void addAndTruncate(int a, int b, int c, int d, int e) {
    this.a = (this.a + a) & BIT_MASK_32;
    this.b = (this.b + b) & BIT_MASK_32;
    this.c = (this.c + c) & BIT_MASK_32;
    this.d = (this.d + d) & BIT_MASK_32;
    this.e = (this.e + e) & BIT_MASK_32;
  }
}
