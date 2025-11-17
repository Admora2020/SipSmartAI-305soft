import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDLt8XoiFSvV3FQfgKaWBWCxqUTe2CHgSs",
            authDomain: "sip-smart-a-i-w3ot2f.firebaseapp.com",
            projectId: "sip-smart-a-i-w3ot2f",
            storageBucket: "sip-smart-a-i-w3ot2f.firebasestorage.app",
            messagingSenderId: "171672746971",
            appId: "1:171672746971:web:1b53702f8abe4ffdb385fe",
            measurementId: "G-PJ26M7F8YB"));
  } else {
    await Firebase.initializeApp();
  }
}
