import 'package:flutter/material.dart';
import 'package:flutter_task/Controllers/routes_controller.dart';
import 'package:flutter_task/Models/buses_model.dart';
import 'package:provider/provider.dart';

class CustomMarkerWidget extends StatelessWidget {
  final BusesModel busModel;
  const CustomMarkerWidget({super.key, required this.busModel});

  @override
  Widget build(BuildContext context) {
    final RoutesController routesController =
        Provider.of<RoutesController>(context);
    return SizedBox(
      height: 140,
      width: 140,
      child: Stack(
        children: [
          routesController.polyGoneRouteId == busModel.routeID
              ? Image.asset('assets/ic_wmata_tap.png')
              : Image.asset('assets/ic_wmata.png'),
          const Icon(
            Icons.arrow_forward,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
