import 'package:dexwidget/dashboard/dashboardViewModel.dart';
import 'package:dexwidget/dashboard/sections/walletInformationSection/walletInformationView.dart';
import 'package:dexwidget/models/ecrToken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerWidget {
  final List<ERC20Token> tokens;
  final String walletAddress;

  const DashboardView({
    super.key,
    required this.tokens,
    required this.walletAddress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = (tokens: tokens, walletAddress: walletAddress);

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
      body: content(ref, params),
    );
  }

  Widget content(
    WidgetRef ref,
    ({List<ERC20Token> tokens, String walletAddress}) params,
  ) {
    final state = ref.watch(dashboardViewModel);

    return Scrollbar(
      child: Column(children: [WalletInformationView(walletId: state.walletAddress, walletBalance: state.walletBalance,)]),
    );
  }
}
