
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCamebQyA1InpvnfoCp_p_ozcoo5scS8vc',
    appId: '1:883702583216:web:fe2ddeda94bc65db649075',
    messagingSenderId: '883702583216',
    projectId: 'noteapp-b4788',
    authDomain: 'noteapp-b4788.firebaseapp.com',
    storageBucket: 'noteapp-b4788.firebasestorage.app',
    measurementId: 'G-7TPM5ZHTW1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2WVa25E4-X14-Miu9ko1KvGE-3l-R-20',
    appId: '1:883702583216:android:773fba5a506ec24b649075',
    messagingSenderId: '883702583216',
    projectId: 'noteapp-b4788',
    storageBucket: 'noteapp-b4788.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpWSwA3eYnRzoG37ZG7LAdQguOCC4rRiU',
    appId: '1:883702583216:ios:cab473b77ce69cab649075',
    messagingSenderId: '883702583216',
    projectId: 'noteapp-b4788',
    storageBucket: 'noteapp-b4788.firebasestorage.app',
    iosBundleId: 'com.example.noteapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBpWSwA3eYnRzoG37ZG7LAdQguOCC4rRiU',
    appId: '1:883702583216:ios:cab473b77ce69cab649075',
    messagingSenderId: '883702583216',
    projectId: 'noteapp-b4788',
    storageBucket: 'noteapp-b4788.firebasestorage.app',
    iosBundleId: 'com.example.noteapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCamebQyA1InpvnfoCp_p_ozcoo5scS8vc',
    appId: '1:883702583216:web:caf07eee4d3fbbf9649075',
    messagingSenderId: '883702583216',
    projectId: 'noteapp-b4788',
    authDomain: 'noteapp-b4788.firebaseapp.com',
    storageBucket: 'noteapp-b4788.firebasestorage.app',
    measurementId: 'G-V9QFMFLS9D',
  );
}
