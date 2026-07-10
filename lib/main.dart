import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/view_model/bus_data.dart';
import 'package:cawil/data/resources/auth_methods.dart';
import 'package:cawil/view/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'view/screens/intro_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  await Hive.openBox<dynamic>('auth');
  await Hive.openBox<dynamic>('user_profile');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<bool>(
          future: AuthMethods.hasSavedSession(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: whiteColor,
                ),
              );
            }

            if (snapshot.data == true) {
              return const Homepage();
            }

            return const IntroductionScreen();
          },
        ),
      ),
    );
  }
}
