import 'constants.dart';

/// Rotates `n` left by one bit as if it were a 32 bit number
int leftRotate32(int n, int amount) {
  // intuition for rotate 4 bit example 1010 left 1:
  // 1010 shift right 3 = 0001
  // 1010 shift left 1 = 0100
  // 0001 | 0100 = 0101
  // mask throws away all extra bits past 32.
  // Done before in rs to prevent bits from creeping in, and after in ls to get rid of bits that escaped
  var rs = (n & BIT_MASK_32) >> (32 - amount);
  var ls = (n << amount) & BIT_MASK_32;
  return rs | ls;
}
