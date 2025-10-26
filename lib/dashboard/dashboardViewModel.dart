import 'package:dexwidget/models/ecrToken.dart';
import 'package:dexwidget/models/walletNetWorth.dart';
import 'package:dexwidget/service/dexNetworkService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';

class DashboardViewState {
  final WalletNetWorth walletData;
  final List<ERC20Token> tokens;
  final String walletAddress;

  const DashboardViewState({
    this.tokens = const [],
    WalletNetWorth? walletData,
    this.walletAddress = '',
  }) : walletData = walletData ?? const WalletNetWorth(
          totalNetworthUsd: "0",
          chains: [],
        );

  DashboardViewState copyWith({
    WalletNetWorth? walletData,
    List<ERC20Token>? tokens,
    String? walletAddress,
  }) {
    return DashboardViewState(
      walletData: walletData,
      tokens: tokens ?? this.tokens,
      walletAddress: walletAddress ?? this.walletAddress,
    );
  }
}

class DashboardViewModel extends Notifier<DashboardViewState> {
  final service = DexNetworkService();

  @override
  DashboardViewState build() {
    return const DashboardViewState();
  }

  // Method to initialize the state with data from the parent widget
  void initializeWithData({
    required String walletAddress,
  }) {
    state = state.copyWith(
      walletAddress: walletAddress,
    );

    getWalletBalance();
    getTokens();
  }

  Future<void> getWalletBalance() async {
    if (state.walletAddress.isEmpty) return;

    try {
      final walletNetWorth = await service.fetchWalletBalance(
        state.walletAddress,
      );
      state = state.copyWith(walletData: walletNetWorth);
    } catch (e) {
      
    }
  }

  //Check if wallet exist or not by checking the wallet balance
  Future<void> getTokens() async {
    try {
      final tokens = await service.fetchERC20Tokens(state.walletAddress);
      state = state.copyWith(tokens: tokens);
      print(tokens);
    } catch (e) {
      print(e);
      Get.snackbar(
        '',
        e.toString(),
        backgroundColor: const Color(0xFFCF5959),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(milliseconds: 300),
        duration: const Duration(seconds: 3),
        titleText: const SizedBox.shrink(),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        padding: const EdgeInsets.only(top: 0, bottom: 8, left: 12, right: 12),
        borderRadius: 8,
      );
    }
  }
}

final dashboardViewModel =
    NotifierProvider<DashboardViewModel, DashboardViewState>(
      DashboardViewModel.new,
    );
