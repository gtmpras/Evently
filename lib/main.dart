import 'package:evently/app_config/state_list.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/src/partners/routes/app_router.dart';
import 'package:evently/src/presentations/create_events/create_event_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
      providers: myStateList,
    child:  MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routerConfig = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig.router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
