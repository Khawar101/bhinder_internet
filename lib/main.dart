import 'package:bhinder_internet/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bhinder_internet/app/app.bottomsheets.dart';
import 'package:bhinder_internet/app/app.dialogs.dart';
import 'package:bhinder_internet/app/app.locator.dart';
import 'package:bhinder_internet/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: 
   DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Theme.of(context).copyWith(
        // primaryColor: kcBackgroundColor,
        // focusColor: kcPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
            ),
      ),
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
