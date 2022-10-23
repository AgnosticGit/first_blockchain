import 'block.dart';

class Blockchain {
  List<Block> blocks = [Block.genesis()];

  int difficulty = 2;

  void addBlock(String data) {
    final newBlock = Block(
      data: data,
      timestamp: DateTime.now(),
      prevHash: blocks.last.hash,
      difficulty: difficulty,
    )..mineBlock(blocks.last, data);

    blocks.add(newBlock);
  }

  bool isValid() {
    for (int i = 1; i < blocks.length; i++) {
      final b1 = blocks[i - 1];
      final b2 = blocks[i];

      final hashIsValid = b2.hash == b2.calculateBlockHash();
      final hashesAreConvinient = b2.prevHash == b1.hash;

      if (!hashIsValid || !hashesAreConvinient) {
        return false;
      }
    }

    return true;
  }

  @override
  String toString() {
    return blocks.toString();
  }
}
