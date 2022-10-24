import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'transaction.dart';

class Block {
  Block({
    required this.transactions,
    required this.prevHash,
    required this.difficulty,
    required this.timestamp,
    this.hash = '',
    this.nounce = 0,
  });

  final String prevHash;
  final List<Transaction> transactions;
  final int difficulty;
  DateTime timestamp;
  String hash;
  int nounce = 0;

  factory Block.genesis() {
    return Block(
      prevHash: '',
      transactions: [],
      timestamp: DateTime.parse('2022-01-01'),
      hash: '00000000000000',
      difficulty: 0,
    );
  }

  Block mineBlock(Block lastBlock) {
    final zeros = getZeros(difficulty);
    hash = calculateBlockHash();

    while (hash.substring(0, difficulty) != zeros) {
      nounce++;
      timestamp = DateTime.now();
      hash = calculateHash(prevHash, timestamp, transactions, nounce);
    }

    return Block(
      transactions: transactions,
      prevHash: prevHash,
      timestamp: timestamp,
      hash: hash,
      difficulty: difficulty,
      nounce: nounce,
    );
  }

  String calculateBlockHash() {
    final mixedData = prevHash +
        timestamp.millisecondsSinceEpoch.toString() +
        transactions.toString() +
        nounce.toString();
    final bytes = utf8.encode(mixedData);
    final hashed = sha256.convert(bytes);

    return hashed.toString();
  }

  static String calculateHash(
    String prevHash,
    DateTime timestamp,
    List<Transaction> transactions,
    int nounce,
  ) {
    final mixedData = prevHash +
        timestamp.millisecondsSinceEpoch.toString() +
        transactions.toString() +
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
    return '\n\nhash: $hash\nprevHash: $prevHash\ntransactions: $transactions\ntimestamp: $timestamp\nnounce: $nounce';
  }
}
