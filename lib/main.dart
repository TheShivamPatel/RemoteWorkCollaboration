import 'package:chatterbox/firebase_options.dart';
import 'package:chatterbox/provider/task_list_provider.dart';
import 'package:chatterbox/screens/auth_screen.dart';
import 'package:chatterbox/screens/bottom_tab_views/bottom_tab.dart';
import 'package:chatterbox/screens/chat_screen.dart';
import 'package:chatterbox/screens/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => TaskListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Welcome'),);
            }
            if (userSnapshot.hasData) {
              return const DashboardTabLayout();
            }
            return AuthScreen();
          },
        ),
      ),
    );
  }
}
