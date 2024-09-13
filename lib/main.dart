import 'package:flutter/material.dart';
import 'package:my_windows_app/providers/cart.dart';
import 'package:my_windows_app/route/route_constants.dart';
import 'package:my_windows_app/route/router.dart' as router;
import 'package:my_windows_app/theme/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Make the app full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// Thanks for using our template. You are using the free version of the template.
// 🔗 Full template: https://theflutterway.gumroad.com/l/fluttershop

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Template by The Flutter Way',
      theme: AppTheme.lightTheme(context),
      // Dark theme is included in the Full template
      themeMode: ThemeMode.light,
      onGenerateRoute: router.generateRoute,
      initialRoute: entryPointScreenRoute,
    );
  }
}
