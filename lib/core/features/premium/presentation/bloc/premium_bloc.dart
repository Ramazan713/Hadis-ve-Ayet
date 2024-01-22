import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/extensions/resource_extension.dart';
import 'package:hadith/core/features/premium/domain/models/premium_result.dart';
import 'package:hadith/core/features/premium/domain/repo/premium_repo.dart';

import 'premium_event.dart';
import 'premium_state.dart';

class PremiumBloc extends Bloc<IPremiumEvent, PremiumState> {

  late final PremiumRepo _premiumRepo;

  PremiumBloc({
    required PremiumRepo premiumRepo
  }) :super(PremiumState.init()) {

    _premiumRepo = premiumRepo;

    on<PremiumEventInit>(_onInit, transformer: restartable());
    on<PremiumEventLoadProducts>(_onLoadProducts, transformer: restartable());
    on<PremiumEventMakePurchase>(_onMakePurchase, transformer: restartable());
    on<PremiumEventCheckPurchase>(_onCheckPurchases,transformer: restartable());

    add(PremiumEventInit());
  }

  Future<void> _onInit(PremiumEventInit event, Emitter<PremiumState> emit) async {
    await _premiumRepo.isAvailable();
    final isPremium = await _premiumRepo.hasPremium();
    emit(state.copyWith(isPremium: isPremium));

    final streamData = _premiumRepo.resultStream;
    await emit.forEach<PremiumResult>(streamData, onData: (result){
      return state.copyWith(
        error: result.error,
        isPremium: result.isPremium,
        isLoading: result.isLoading
      );
    });
  }

  void _onLoadProducts(PremiumEventLoadProducts event, Emitter<PremiumState> emit) async {

    emit(state.copyWith(isLoading: true));
    final response = await _premiumRepo.loadProducts();

    response.handle(
      onSuccess: (data){
        emit(state.copyWith(
          isLoading: false,
          items: data
        ));
      },
      onError: (error){
        emit(state.copyWith(
          isLoading: false,
          error: error
        ));
      }
    );
  }

  void _onMakePurchase(PremiumEventMakePurchase event, Emitter<PremiumState> emit) async {
    await _premiumRepo.purchase(event.productDetails);
  }

  void _onCheckPurchases(PremiumEventCheckPurchase event, Emitter<PremiumState> emit) async {
    emit(state.copyWith(isLoading: true));
    final isPremium = await _premiumRepo.hasPremium();
    emit(state.copyWith(isLoading: false, isPremium: isPremium));
  }

}
