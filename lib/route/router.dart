import 'package:flutter/material.dart';
import 'package:my_windows_app/entry_point.dart';

import 'screen_export.dart';

// ℹ️ All the comments screen are included in the full template
// 🔗 Full template: https://theflutterway.gumroad.com/l/fluttershop

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case mainScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const MainScreen(),
      );
    case loginScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case dataEntryScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const DataEntryScreen(),
      );
    case searchScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      );
    case entryPointScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EntryPoint(),
      );
    default:
      return MaterialPageRoute(
        // Make a screen for undefine
        builder: (context) => const LoginScreen(),
      );
  }
}
