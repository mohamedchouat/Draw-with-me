import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drawwithme/features/ar_viewer/infrastructure/widgets/ar_viewer_screen.dart';
import 'package:drawwithme/features/ar_viewer/adapters/ar_viewer_presenter.dart';
import 'package:drawwithme/injections.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ARViewerPresenter()),
      ],
      child: MaterialApp(
        title: 'Draw With Me',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const ARViewerScreen(),
      ),
    );
  }
}
