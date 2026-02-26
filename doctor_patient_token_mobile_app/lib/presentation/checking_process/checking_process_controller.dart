import 'dart:async';

import 'package:doctor_patient_token_mobile_app/data/api/request/checked_patient_request.dart';
import 'package:doctor_patient_token_mobile_app/di/client_module.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/checked_token_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../app/utils/util.dart';
import '../../domain/entity/token_status_entity.dart';
import '../../domain/usecase/fetch_all_token_statuses_use_case.dart';

class CheckingProcessController extends GetxController with ClientModule {
  CheckingProcessController(
      {required this.fetchAllTokenStatusesUseCase,
      required this.checkedTokenUseCase});
  final FetchAllTokenStatusesUseCase fetchAllTokenStatusesUseCase;
  final CheckedTokenUseCase checkedTokenUseCase;

  var currentTime = ''.obs;
  late Timer _timer;

  RxList<TokenStatus?> allTokenStatusList = <TokenStatus?>[].obs;
  final selectedTokenNumber = RxnInt();

  @override
  void onInit() {
    super.onInit();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  @override
  void onReady() {
    super.onReady();
    fetchAllTokenStatuses();
  }

  void _updateTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('hh:mm a').format(now);
    currentTime.value = formattedTime;
  }

  Future<void> fetchAllTokenStatuses() async {
    try {
      final result = await fetchAllTokenStatusesUseCase.execute();
      if (result != null) {
        allTokenStatusList.value = result.tokens;
      } else {
        print("result null error occured");
      }
    } catch (e) {
      print("fetch all token exception occured");
    }
  }

  Future<void> checkedToken(
    String tokenId,
    String status, {
    required Function(bool success) onResult,
  }) async {
    var checkedPatientRequest =
        CheckedPatientRequest(tokenId: tokenId, status: status);
    try {
      Util.showLoadingIndicator();

      final result = await checkedTokenUseCase.execute(checkedPatientRequest);
      if (result != null) {
        Util.hideLoadingIndicator();
        onResult(true);
      } else {
        Util.hideLoadingIndicator();
        onResult(false);
      }
    } catch (e) {
      Util.hideLoadingIndicator();
      debugPrint("Checked Token Exception: ${e.toString()}");
      onResult(false);
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
