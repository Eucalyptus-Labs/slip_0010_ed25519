import 'package:convert/convert.dart';
import 'package:slip_0010_ed25519/slip_0010_ed25519.dart';
/*
After much research on what exact version of ed25519 scheme is best, we decided to go with [SLIP-0010](https://github.com/satoshilabs/slips/blob/master/slip-0010.md) for koala wallet.

The justification for this is beautifully summarized at [Oasis's ADR 0008](https://docs.oasis.io/adrs/0008-standard-account-key-generation/#alternatives)

In addition, it seems like many ed25519 account based blockchains are implemented this way at both [Trezor](https://github.com/trezor/trezor-firmware/blob/master/docs/misc/coins-bip44-paths.md), [Trust](https://github.com/trustwallet/wallet-core/blob/master/registry.json#L9) and even some of Ledger's nanos implementations.
*/
void main() async {

  // To get the bip39Seed from a koala-wallet 24 word recovery phrase use Ian Coleman's [Mnemonic Code Converter](https://iancoleman.io/bip39/) site.
  // For example: plug utility enable phone tip scale left blind clown someone knife oval drink road want erase salt jewel move whisper picnic history avocado symbol
  String bip39Seed =
      '68935a8df9bd58690ed56c17146d2a302fb9e536d8a9197235ffe749a77cac182811ac8d198329fc752e8c69fdac0d5a27a81c9e7b1c1b98225a574bcdad8d9d';
  List<int> seedBytes = hex.decode(bip39Seed);
  KeyData keyData = await ED25519_HD_KEY.derivePath("m/44'/626'/0'", seedBytes);
  var privateKey = await keyData.key;
  var publicKey = await ED25519_HD_KEY.getPublicKey(keyData.key, false);
  print('private key: ${hex.encode(privateKey)}');
  print('public key: ${hex.encode(publicKey)}');
  print('K-address: k:${hex.encode(publicKey)}');
}
