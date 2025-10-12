import 'package:dexwidget/components/mainButton.dart';
import 'package:dexwidget/components/mainTextField.dart';
import 'package:dexwidget/dexLogin/dexLoginViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DexInputView extends ConsumerWidget {
  const DexInputView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF100F0F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: content(ref),
        ),
      ),
    );
  }

  Widget content(WidgetRef ref) {
    final state = ref.watch(dexInputViewModel);
    final vm = ref.read(dexInputViewModel.notifier);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          const Text(
            "Enter your Wallet Address",
            style: TextStyle(fontFamily: 'Jura', fontSize: 24),
          ),
          MainTextField(
            hintText: "0xff",
            onChanged: vm.onAddressChanged,
          ),
          MainButton(
            label: "Continue",
            loading: state.isLoading,
            onPressed:
                state.canSubmit ? () => vm.submit() : null,
          ),
        ],
      ),
    );
  }
}
