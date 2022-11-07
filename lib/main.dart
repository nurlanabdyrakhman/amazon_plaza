import 'package:amazon_plaza/screens/sign_in_screen.dart';
import 'package:amazon_plaza/utils/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout/screen_layout.dart';
import 'providers/user_details_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAzQ9sV0ymwa8HB_VU-CMNPSVAideyrbdg",
          authDomain: "plaza-80235.firebaseapp.com",
          projectId: "plaza-80235",
          storageBucket: "plaza-80235.appspot.com",
          messagingSenderId: "954935895311",
          appId: "1:954935895311:web:2471aa80e37bacea0dca7a"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amazon plaze',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                ),
              );
            } else if (user.hasData) {
              return const ScreenLayout();
              //return const SellScreen();
            } else {
              return const SignInScreen();
              //return const ScreenLayout();
            }
          },
        ),
      ),
    );
  }
}
// flutter run -d chrome --web-renderer html