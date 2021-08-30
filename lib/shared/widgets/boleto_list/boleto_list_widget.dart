import 'package:flutter/material.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_status.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';

class BoletoListWidget extends StatefulWidget {
  final BoletoListController controller;
  const BoletoListWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BoletoListStatus>(
      valueListenable: widget.controller.boletosNotifier,
      builder: (_, value, __) {
        return Column(
          children: value.success
              ? value.boletos
                  .map((boleto) => BoletoTileWidget(data: boleto))
                  .toList()
              : [Container()],
        );
      },
    );
  }
}
