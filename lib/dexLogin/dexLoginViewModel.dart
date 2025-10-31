import 'package:dexwidget/service/dexNetworkService.dart';
import 'package:dexwidget/dashboard/dashboardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DexInputState {
  const DexInputState({this.address = '', this.isLoading = false});

  final String address;
  final bool isLoading;

  bool get canSubmit => address.trim().isNotEmpty && !isLoading;

  DexInputState copyWith({String? address, bool? isLoading}) {
    return DexInputState(
      address: address ?? this.address,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class DexLoginViewModel extends Notifier<DexInputState> {
  static const walletAddressKey = 'wallet_address';

  @override
  DexInputState build() => const DexInputState();

  final service = DexNetworkService();

  void onAddressChanged(String value) {
    state = state.copyWith(address: value);
  }

  Future<void> submit() async {
    if (!state.canSubmit) {
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      await performDexLookup();
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  //Check if wallet exist or not by checking the wallet balance
  Future<void> performDexLookup() async {
    try {
      final address = state.address.trim();
      final walletNetWorth = await service.fetchWalletBalance(address);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(walletAddressKey, address);

      Get.to(
        () => DashboardView(
          walletBalance: walletNetWorth.totalNetworthUsd,
          walletAddress: address,
        ),
      );
    } catch (e) {
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

final dexLoginViewModel = NotifierProvider<DexLoginViewModel, DexInputState>(
  DexLoginViewModel.new,
);
