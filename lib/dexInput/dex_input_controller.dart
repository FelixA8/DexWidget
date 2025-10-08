import 'package:flutter_riverpod/legacy.dart';

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

class DexInputController extends StateNotifier<DexInputState> {
  DexInputController() : super(const DexInputState());

  void onAddressChanged(String value) {
    state = state.copyWith(address: value);
  }

  Future<void> submit() async {
    if (!state.canSubmit) {
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      await _performDexLookup();
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _performDexLookup() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}

final dexInputControllerProvider =
    StateNotifierProvider<DexInputController, DexInputState>(
      (ref) => DexInputController(),
    );
