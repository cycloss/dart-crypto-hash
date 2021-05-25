import 'dart:typed_data';

import 'package:crypto_hash/src/constants.dart';
import 'package:crypto_hash/src/utils.dart';
import 'package:typed_data/typed_buffers.dart';

// The data caretaker.
/// Serves up the next block of data for the SHA-1 hasing algorithm.
/// Signals when processing is done with [hasMoreSchedules].
/// Adds padding to final block.
class DataToHash {
  // the block size in bytes (64)
  static const BLOCK_SIZE = 512 ~/ 8;
  // the number of 32 bit words required for the schedule
  static const WORD32_COUNT = 80;
  // 9 bytes for byte divider plus 64 bit original message length byte count
  static const DIVIDER_AND_SIZE = 9;

  // longer messages are not supported by both Dart VM and JS
  // 2^53 - 1
  static const MAX_BYTE_LEN = 0x0003ffffffffffff;

  // Allows retreival of uint32 from a list of uint8
  late ByteData data;
  int nextByte = 0;
  late int lastByteOffset;

  DataToHash(List<int> data) {
    // initialise the random access buffer
    var uint8Buf = Uint8Buffer();
    uint8Buf.addAll(data);
    _addPadding(uint8Buf);
    lastByteOffset = uint8Buf.lengthInBytes - 1;
    this.data = uint8Buf.buffer.asByteData();
  }

  void _addPadding(Uint8Buffer uint8buf) {
    var originalLen = uint8buf.lengthInBytes;

    // separator byte
    uint8buf.add(0x80);
    // 512 bits = 64 bytes
    var mod = (uint8buf.lengthInBytes * 8) % 512;
    // 448 bits = 56 bytes
    if (mod < 448) {
      // if was less then 512 - mod is number of bytes needed to make it 448
      uint8buf.addAll(List.generate((448 - mod) ~/ 8, (i) => 0x0));
    } else if (mod > 448) {
      uint8buf.addAll(List.generate(((512 - mod) ~/ 8) + 56, (i) => 0x0));
    }
    // else there was the perfect number of bits to just add the length.
    var buffLen = uint8buf.lengthInBytes;

    assert(buffLen % 64 == 56);

    uint8buf.addAll(generateLengthBytes(originalLen * 8));

    if (uint8buf.lengthInBytes > MAX_BYTE_LEN) {
      throw UnsupportedError('Cannot hash data of more than 2^53 bytes');
    }
  }

  List<int> generateLengthBytes(int buffLen) {
    var lenBytes = <int>[];
    for (var i = 56; i >= 0; i -= 8) {
      lenBytes.add(buffLen >> i);
    }
    return lenBytes;
  }

  /// Generates the message schedule for an iteration.
  /// Schedule consists of 80 32 bit words derived from a 512 bit block
  List<int> getNextSchedule() {
    var schedule = List.filled(80, 0, growable: false);
    for (var i = 0; i < WORD32_COUNT; i++) {
      if (i < 16) {
        schedule[i] = data.getUint32(nextByte);
        nextByte += 4;
      } else {
        // xor to derive the rest of the schedule
        var xored = schedule[i - 3] ^
            schedule[i - 8] ^
            schedule[i - 14] ^
            schedule[i - 16];
        schedule[i] = leftRotate32(xored, 1);
      }
      assert(schedule[i] == schedule[i] & BIT_MASK_32);
    }

    return schedule;
  }

  bool get hasMoreSchedules => nextByte < lastByteOffset;
}
