import 'package:crypto_hash/src/utils.dart';

import 'constants.dart';
import 'context.dart';
import 'data.dart';

// Contains the hashing algorithm business logic
/// Contains methods that hash data using the SHA-1 hashing algorithm.
class ShaOne {
  static const _K1 = 0x5A827999;
  static const _K2 = 0x6ED9EBA1;
  static const _K3 = 0x8F1BBCDC;
  static const _K4 = 0xCA62C1D6;
  static const _STAGE_COUNT = 80;

  /// Hashes [data] using the SHA-1 hashing algorithm.
  /// [data] must effectively be 8 bit integers.
  /// Bits past the first byte in each int will be discarded.
  static String hashData(List<int> data) {
    var context = Sha1Context();
    var dataToHash = DataToHash(data);
    while (dataToHash.hasMoreSchedules) {
      var schedule = dataToHash.getNextSchedule();
      _processSchedule(context, schedule);
    }
    return context.getHash();
  }

  // The compression function
  static void _processSchedule(Sha1Context ctx, List<int> schedule) {
    var a = ctx.a, b = ctx.b, c = ctx.c, d = ctx.d, e = ctx.e;
    for (var j = 0; j < _STAGE_COUNT; j++) {
      var fRes = 0;
      if (j < 20) {
        fRes += _K1;
        // d should have 0s as 32 msbs so ~b's 1's in the 32 msbs should be cut off
        var r = (b & c) | ((~b) & d);
        fRes += r;
      } else if (j < 40) {
        fRes += _K2;
        var r = b ^ c ^ d;
        fRes += r;
      } else if (j < 60) {
        fRes += _K3;
        fRes += (b & c) | (b & d) | (c & d);
      } else {
        fRes += _K4;
        fRes += b ^ c ^ d;
      }

      // add together and throw away overflow bit
      var temp = (fRes + e + leftRotate32(a, 5) + schedule[j]) & BIT_MASK_32;
      // swap values
      e = d;
      d = c;
      c = leftRotate32(b, 30);
      b = a;
      a = temp;
      // For dev, check there is never any overflow
      assert(a == a & BIT_MASK_32);
      assert(b == b & BIT_MASK_32);
      assert(c == c & BIT_MASK_32);
      assert(d == d & BIT_MASK_32);
      assert(e == e & BIT_MASK_32);
    }
    ctx.addAndTruncate(a, b, c, d, e);
  }

  ShaOne._();
}
