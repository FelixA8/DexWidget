import 'package:dexwidget/components/service/dexNetworkService.dart';
import 'package:dexwidget/dashboard/dashboardView.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

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

class DexInputViewModel extends StateNotifier<DexInputState> {
  DexInputViewModel() : super(const DexInputState());

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

  Future<void> performDexLookup() async {
    final tokens = service.fetchERC20Tokens(state.address);
    print(tokens);
    await Future.delayed(const Duration(seconds: 3));
    Get.to((DashboardView()));
  }
}

final dexInputViewModel =
    StateNotifierProvider<DexInputViewModel, DexInputState>(
      (ref) => DexInputViewModel(),
    );
