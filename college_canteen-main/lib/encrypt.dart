import 'package:encrypt/encrypt.dart%20';

class EncryptData{
//for AES Algorithms

  static Encrypted? encrypted;
  static var decrypted;


   encryptAES(plainText){
    final key = Key.fromUtf8('63035836077396152396912387654314');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    return(encrypted!.base64);
  }

   decryptAES(plainText){
    final key = Key.fromUtf8('63035836077396152396912387654314');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    decrypted = encrypter.decrypt(encrypted!, iv: iv);
    return(decrypted);
  }
}
