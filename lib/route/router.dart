import 'package:flutter/material.dart';

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
    case addLowDownScreenRoute:
      return MaterialPageRoute(
        builder: (context) {
          final String? dataEntryId = settings.arguments as String?;
          return AddLowDownScreen(dataEntryId: dataEntryId);
        },
      );
    case viewLowDownScreenRoute:
      return MaterialPageRoute(
        builder: (context) {
          final String dataEntryId = settings.arguments as String;
          return ViewLowDownScreen(dataEntryId: dataEntryId);
        },
      );
    default:
      return MaterialPageRoute(
        // Make a screen for undefine
        builder: (context) => const LoginScreen(),
      );
  }
}
