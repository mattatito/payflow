import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoListController {
  final boletosNotifier = ValueNotifier<BoletoListStatus>(BoletoListStatus());
  BoletoListStatus get status => boletosNotifier.value;
  set status(BoletoListStatus value) => boletosNotifier.value = value;

  BoletoListController() {
    getBoletos();
  }

  Future<void> getBoletos() async {
    try {
      status = BoletoListStatus.loading();
      final prefsInstance = await SharedPreferences.getInstance();
      final response = prefsInstance.getStringList("boletos") ?? <String>[];

      final boletos = response.map((e) => BoletoModel.fromJson(e)).toList();
      final paidBoletos =
          boletos.where((element) => element.paid == true).toList();

      status = BoletoListStatus.successBoleto(boletos, paidBoletos);
    } catch (error) {
      status = BoletoListStatus.error(error.toString());
    }
  }
}
