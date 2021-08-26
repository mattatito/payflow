import 'dart:ffi';

import 'package:payflow/shared/models/boleto_model.dart';

class BoletoListStatus {
  final List<BoletoModel> boletos;
  final List<BoletoModel> paidBoletos;
  final bool success;
  final String error;
  final bool loading;

  BoletoListStatus(
      {this.boletos = const <BoletoModel>[],
      this.paidBoletos = const <BoletoModel>[],
      this.success = false,
      this.error = "",
      this.loading = false});

  factory BoletoListStatus.successBoleto(
          List<BoletoModel> boletos, List<BoletoModel> paidBoletos) =>
      BoletoListStatus(
        success: true,
        boletos: boletos,
        paidBoletos: paidBoletos,
      );

  factory BoletoListStatus.error(String message) =>
      BoletoListStatus(error: message);

  factory BoletoListStatus.loading() => BoletoListStatus(loading: true);
}
