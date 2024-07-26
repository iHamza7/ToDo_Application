import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common/models/user_model.dart';
import 'common/routes/routes.dart';
import 'common/utils/constants.dart';
import 'features/authentication/controllers/user_controller.dart';
import 'features/todo/pages/homepage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final defaulLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  static final defaulDarkColorScheme = ColorScheme.fromSwatch(
      brightness: Brightness.dark, primarySwatch: Colors.blue);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> user = ref.watch(userProvider);
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 825),
        minTextAdapt: true,
        builder: (context, child) {
          return DynamicColorBuilder(
              builder: (lightColorScheme, darkColorScheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ToDo Applicatiocjjjnss',
              theme: ThemeData(
                scaffoldBackgroundColor: AppConst.kBkDark,
                colorScheme: lightColorScheme ?? defaulLightColorScheme,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme ?? defaulDarkColorScheme,
                scaffoldBackgroundColor: AppConst.kBkDark,
                useMaterial3: true,
              ),
              themeMode: ThemeMode.dark,
              home: const HomePage(),
              // user.isEmpty ? const OnBoarding() : const HomePage()
              onGenerateRoute: Routes.onGenerateRoute,
            );
          });
        });
  }
}
