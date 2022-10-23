import 'package:crypto/crypto.dart';
import 'dart:convert';

class Block {
  Block({
    required this.data,
    required this.prevHash,
    required this.difficulty,
    this.timestamp,
    this.hash = '',
    this.nounce = 0,
  });

  final String prevHash;
  final String data;
  final int difficulty;
  DateTime? timestamp;
  String hash;
  int nounce = 0;

  factory Block.genesis() {
    return Block(
      prevHash: '',
      data: 'Genesis block',
      timestamp: DateTime.parse('2022-01-01'),
      hash: '00000000000000',
      difficulty: 0,
    );
  }

  Block mineBlock(Block lastBlock, String data) {
    final zeros = getZeros(difficulty);
    hash = calculateBlockHash();

    while (hash.substring(0, difficulty) != zeros) {
      nounce++;
      timestamp = DateTime.now();
      hash = calculateHash(prevHash, timestamp!, data, nounce);
    }

    return Block(
      data: data,
      prevHash: prevHash,
      timestamp: timestamp,
      hash: hash,
      difficulty: difficulty,
      nounce: nounce,
    );
  }

  String calculateBlockHash() {
    timestamp = timestamp ?? DateTime.now();

    final mixedData = prevHash +
        timestamp!.millisecondsSinceEpoch.toString() +
        data +
        nounce.toString();
    final bytes = utf8.encode(mixedData);
    final hashed = sha256.convert(bytes);

    return hashed.toString();
  }

  static String calculateHash(
    String prevHash,
    DateTime timestamp,
    String data,
    int nounce,
  ) {
    final mixedData = prevHash +
        timestamp.millisecondsSinceEpoch.toString() +
        data +
        nounce.toString();
    final bytes = utf8.encode(mixedData);
    final hashed = sha256.convert(bytes);

    return hashed.toString();
  }

  static String getZeros(int difficulty) {
    String zeros = '';

    for (int i = 0; i < difficulty; i++) {
      zeros += '0';
    }

    return zeros;
  }

  @override
  String toString() {
    return '\n\nhash: $hash\nprevHash: $prevHash\ndata: $data\ntimestamp: $timestamp\nnounce: $nounce';
  }
}
