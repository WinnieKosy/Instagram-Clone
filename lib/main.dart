import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responses/mobile_screen_layout.dart';
import 'package:instagram_clone/responses/responsive_layout.dart';
import 'package:instagram_clone/responses/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: "AIzaSyCerGzxJQJoU3DKd6SZgati4JN3_-hhAHM", appId: "1:868650203393:web:639b7e71055feef9870300", messagingSenderId:"868650203393" , projectId: "instagram-app-f6157",
      storageBucket: "instagram-app-f6157.appspot.com")
    );
  } else{
  await Firebase.initializeApp();
  runApp(const MyApp());}
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:" Instagram Clone",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: blueColor
      ),
     // home:const ResponsiveLayout(mobileScreenLayout:MobileScreen(),webScreenLayout:WebScreen() ,),);
    home: const LoginScreen()
    );
  }
}

