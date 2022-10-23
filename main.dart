import 'block.dart';
import 'blockchain.dart';

void main() {
  final blockChain = Blockchain();

  blockChain.addBlock('Слава должен диме 500 рублей');
  blockChain.addBlock('Слава должен диме 500 рублей');
  blockChain.addBlock('Слава должен диме 500 рублей');

  print(blockChain.toString());
  print(blockChain.isValid());
}
