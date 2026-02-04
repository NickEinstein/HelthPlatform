import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/ekiosk/data/ekiosk_service.dart';
import 'package:greenzone_medical/src/features/ekiosk/data/model/drug_model.dart';
import 'package:greenzone_medical/src/features/ekiosk/presentation/pages/drug_search_result.dart';
import 'package:greenzone_medical/src/provider/all_providers.dart';

final ekioskServiceProvider = Provider.autoDispose<EKioskService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final apiService = ref.watch(apiServiceProvider);
  return EKioskService(apiService, storageService);
});

class EkioskState {
  final Map<String, List<DrugModel>> drugs;
  final bool isLoading;
  final String? errorMessage;

  const EkioskState({
    this.drugs = const {},
    this.isLoading = false,
    this.errorMessage,
  });

  EkioskState copyWith({
    Map<String, List<DrugModel>>? drugs,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EkioskState(
      drugs: drugs ?? this.drugs,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class EkioskNotifier extends StateNotifier<EkioskState> {
  final EKioskService _ekioskService;

  EkioskNotifier(this._ekioskService) : super(const EkioskState());

  Future<void> search(
    String query, {
    bool pushScreen = false,
    BuildContext? context,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      if (pushScreen) {
        context?.push(DrugSearchResult.routeName);
      }
      final drugs = await _ekioskService.getDrugs(query);
      state = state.copyWith(drugs: drugs, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An error occurred',
      );
    }
  }
}

final ekioskStateProvider =
    StateNotifierProvider<EkioskNotifier, EkioskState>((ref) {
  final ekioskService = ref.watch(ekioskServiceProvider);
  return EkioskNotifier(ekioskService);
});
