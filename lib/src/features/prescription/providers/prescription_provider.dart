// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/routes/old_routes.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/api_client_config.dart';
import '../../../api/api_handler_models.dart';
import '../../../api/app_endpoints.dart';
import '../../../utils/dialogs/dialog.dart';
import '../models/get_prescriptions_model.dart';
import '../models/prescription_model.dart';
import '../models/prescription_reminder_model.dart';

final prescriptionLogProvider = FutureProvider<List<Prescription>>((ref) async {
  final response = await PrescriptionRepo().getPrescriptions();
  return response.data?.data ?? <Prescription>[];
});

final presctiptionProvider =
    NotifierProvider<PrescriptionProvider, PrescriptionRepo>(
        PrescriptionProvider.new);

class PrescriptionProvider extends Notifier<PrescriptionRepo> {
  @override
  PrescriptionRepo build() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshData();
    });
    return PrescriptionRepo();
  }

  Future<void> refreshData() async {
    final res = await state.getPrescriptions();
    res.data?.data?.sort((a, b) {
      return DateFormat('MM/dd/yyyy').parse(b.appointDate ?? '').compareTo(
            DateFormat('MM/dd/yyyy').parse(a.appointDate ?? ''),
          );
    });
    if (res.valid) {
      state = state.copyWith(prescriptions: res.data!);
    }
  }

  Future<void> rescheduleReminder(
      {required PrescriptionByPatientResponse prescription,
      required Duration duration}) async {
    var currentDate =
        DateFormat('MM/dd/yyyy').tryParse(prescription.dispensedDate ?? '');

    if (currentDate == null) return;

    currentDate = currentDate.copyWith(
      hour: int.tryParse(prescription.dispensedDate?.split(':')[0] ?? ''),
      minute: int.tryParse(prescription.dispensedDate?.split(':')[1] ?? ''),
    );
    currentDate = currentDate.add(duration);

    Dialogs.showLoadingDialog();
    final res = await state.rescheduleReminder(
      model: PrescriptionReminderModel(
        id: prescription.id,
        endDate: currentDate,
        startDate: currentDate,
        isReminderActive: true,
        reminderTime: DateFormat('HH:mm').format(currentDate),
      ),
    );

    pop();
    pop();
    if (res.valid) {
      Dialogs.showSuccessSnackbar(message: res.message ?? '');
    } else {
      Dialogs.showErrorSnackbar(message: res.message ?? '');
    }
  }
}

class PrescriptionRepo {
  final BackendService _apiService = BackendService(Dio());

  GetPrescriptionModel? prescriptions;
  PrescriptionRepo({
    this.prescriptions,
  });

  Future<ResponseModel<GetPrescriptionModel>> getPrescriptions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? loginData = prefs.getString('loginData');
    final decodedData = jsonDecode(loginData!);
    final userId = decodedData["userID"];
    Response response = await _apiService.runCall(
      _apiService.dio.get(
        '${AppEndpoints.baseUrl}'
        '/${AppEndpoints.suffix}/api/Prescription/patient/$userId',
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: GetPrescriptionModel.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data),
      statusCode: statusCode,
      message: response.data['message'],
    );
  }

  Future<ResponseModel> rescheduleReminder({
    required PrescriptionReminderModel model,
  }) async {
    Response response = await _apiService.runCall(
      _apiService.dio.put(
        '${AppEndpoints.baseUrl}'
        '/${AppEndpoints.suffix}/api/Prescription/reminder',
        data: model.toJson(),
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.data['message'],
        data: response.data,
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data),
      statusCode: statusCode,
      message: response.data['message'],
    );
  }

  PrescriptionRepo copyWith({
    GetPrescriptionModel? prescriptions,
  }) {
    return PrescriptionRepo(
      prescriptions: prescriptions ?? this.prescriptions,
    );
  }
}
