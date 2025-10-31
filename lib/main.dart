import 'package:dexwidget/dashboard/dashboardView.dart';
import 'package:dexwidget/dexLogin/dexLoginView.dart';
import 'package:dexwidget/dexLogin/dexLoginViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Jura'),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF100F0F),
        colorScheme: const ColorScheme.dark(primary: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF100F0F),
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      home: const _InitialRouteDecider(),
    );
  }
}

class _InitialRouteDecider extends StatefulWidget {
  const _InitialRouteDecider();

  @override
  State<_InitialRouteDecider> createState() => _InitialRouteDeciderState();
}

class _InitialRouteDeciderState extends State<_InitialRouteDecider> {
  late final Future<String?> _walletAddressFuture;

  @override
  void initState() {
    super.initState();
    _walletAddressFuture = _loadSavedWalletAddress();
  }

  Future<String?> _loadSavedWalletAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(DexLoginViewModel.walletAddressKey);
    
    if (saved == null) {
      return null;
    }

    final trimmed = saved.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _walletAddressFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return const DexInputView();
        }

        final savedAddress = snapshot.data;
        if (savedAddress == null) {
          return const DexInputView();
        }

        return DashboardView(
          walletAddress: savedAddress,
          walletBalance: '0',
        );
      },
    );
  }
}
