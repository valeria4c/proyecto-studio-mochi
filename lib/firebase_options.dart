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
    apiKey: 'AIzaSyD-9OKIF5lx9wottWSadPvM7rv1z_xGWLE',
    appId: '1:989807580886:web:37565de836b21e29ee5b77',
    messagingSenderId: '989807580886',
    projectId: 'studio-mochi22px',
    authDomain: 'studio-mochi22px.firebaseapp.com',
    storageBucket: 'studio-mochi22px.firebasestorage.app',
    measurementId: 'G-VP5GXVLKXC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-9OKIF5lx9wottWSadPvM7rv1z_xGWLE',
    appId: '1:989807580886:android:REPLACE',
    messagingSenderId: '989807580886',
    projectId: 'studio-mochi22px',
    storageBucket: 'studio-mochi22px.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-9OKIF5lx9wottWSadPvM7rv1z_xGWLE',
    appId: '1:989807580886:ios:REPLACE',
    messagingSenderId: '989807580886',
    projectId: 'studio-mochi22px',
    storageBucket: 'studio-mochi22px.firebasestorage.app',
    iosBundleId: 'com.example.studiomochi22px',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-9OKIF5lx9wottWSadPvM7rv1z_xGWLE',
    appId: '1:989807580886:ios:REPLACE',
    messagingSenderId: '989807580886',
    projectId: 'studio-mochi22px',
    storageBucket: 'studio-mochi22px.firebasestorage.app',
    iosBundleId: 'com.example.studiomochi22px.RunnerTests',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-9OKIF5lx9wottWSadPvM7rv1z_xGWLE',
    appId: '1:989807580886:web:37565de836b21e29ee5b77',
    messagingSenderId: '989807580886',
    projectId: 'studio-mochi22px',
    storageBucket: 'studio-mochi22px.firebasestorage.app',
  );
}
