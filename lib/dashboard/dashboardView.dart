import 'package:dexwidget/dashboard/dashboardViewModel.dart';
import 'package:dexwidget/dashboard/sections/tokenInformationSection/tokenInformationView.dart';
import 'package:dexwidget/dashboard/sections/walletInformationSection/walletInformationView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  final String walletBalance;
  final String walletAddress;

  const DashboardView({
    super.key,
    required this.walletBalance,
    required this.walletAddress,
  });

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  void initState() {
    super.initState();

    // Initialize the view model with the passed data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(dashboardViewModel.notifier)
          .initializeWithData(walletAddress: widget.walletAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardViewModel);
    final vm = ref.read(dashboardViewModel.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/icons/hamburger.png",
            width: 28,
            height: 28,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
      ),
      body: Scrollbar(
        child: ListView.separated(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: 2,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (_, index) {
            switch (index) {
              case 0:
                return WalletInformationView(
                  walletId: state.walletAddress,
                  walletBalance: state.walletData.totalNetworthUsd,
                );
              case 1:
                return TokenInformationView(tokens: state.tokens);
              default:
                return null;
            }
          },
        ),
      ),
    );
  }
}
