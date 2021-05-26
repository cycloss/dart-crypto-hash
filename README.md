# Crypto Hash

The SHA-1 hash function implemented from scratch using pure dart.

I might add support for SHA-256 in the future.

## Usage

A simple usage example:

```dart
import 'dart:convert';

import 'package:crypto_hash/crypto_hash.dart';

void main() {

  var testString = 'Hello World!';
  var hash = ShaOne.hashData(testString.codeUnits);
  print(hash); // prints 2ef7bde68ce5404e97d5f042f95f89f1c232871

  // Unicode:
  var testString2 = 'こんにちは世界！';
  var hash2 = ShaOne.hashData(utf8.encode(testString2));
  print(hash2); // prints f66b68c765fae864106c7352d06be5df5ab510c3
}

```

## Features and bugs

Let me know if you find any...

## Other

I built this library to improve my understanding of hashing, and it is my first time implementing a (semi) secure hashing algorithm.

I found the following resources useful for learning:

- [Lecture 21: SHA-1 Hash Function by Christof Paar](https://www.youtube.com/watch?v=JIhZWgJA-9o)
- [How Hash Algorithms Work](https://www.metamorphosite.com/one-way-hash-encryption-sha1-data-software)
- [The Wikipedia page](https://en.wikipedia.org/wiki/SHA-1)

I enjoyed doing the project in Dart, but if I did it again i'd just do it in C because there is a fair bit of extra manipulation that has to be done in Dart due to the language only supporting 64 bit integers.
