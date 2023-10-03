import 'package:flutter/material.dart';
import 'package:chatapp/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/chatscreen.dart';
final firebase=FirebaseAuth.instance;//create obj of firebase sdk

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterChat',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 17, 177)),
        ),
        home: StreamBuilder(stream: firebase.authStateChanges(),builder: (ctx,snapshot){
         if(snapshot.connectionState==ConnectionState.waiting)
           {
             return Center(child: CircularProgressIndicator());
           }
          if(snapshot.hasData)
            {
              return Chatscreen();
            }
          else{
            return         Loginpage();

          }
        })
    );
  }
}