import 'package:dexwidget/models/ecrToken.dart';
import 'package:dexwidget/service/dexNetworkService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardViewState {
  final int walletBalance;
  final List<ERC20Token> tokens;
  final String walletAddress;

  const DashboardViewState({
    this.tokens = const [],
    this.walletBalance = 0,
    this.walletAddress = '',
  });

  DashboardViewState copyWith({
    int? walletBalance,
    List<ERC20Token>? tokens,
    String? walletAddress,
  }) {
    return DashboardViewState(
      walletBalance: walletBalance ?? this.walletBalance,
      tokens: tokens ?? this.tokens,
      walletAddress: walletAddress ?? this.walletAddress,
    );
  }
}

class DashboardViewModel extends Notifier<DashboardViewState> {
  @override
  DashboardViewState build() {
    return const DashboardViewState();
  }

  void initialize({
    required List<ERC20Token> tokens,
    required String walletAddress,
  }) {
    state = state.copyWith(
      tokens: tokens,
      walletAddress: walletAddress,
    );
  }

  final service = DexNetworkService();


  Future<void> getWalletAddress() async {
    try {
      final balance = await service.fetchWalletBalance(state.walletAddress);
      state = state.copyWith(walletBalance: balance);
    } catch (e) {
      state = state.copyWith(walletBalance: 0);
    }
  }
}

final dashboardViewModel = NotifierProvider<DashboardViewModel, DashboardViewState>(
  DashboardViewModel.new,
);
