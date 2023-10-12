import 'package:flutter/material.dart';
import 'package:flutter_task/Models/buses_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../Controllers/app_settings.dart';
import '../Controllers/routes_controller.dart';

class CustomInfo extends StatelessWidget {
  final BusesModel busModel;
  const CustomInfo({super.key, required this.busModel});

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    final RoutesController routesController =
        Provider.of<RoutesController>(context);
    // Pass DateTime object as argument in the method
    final fifteenAgo = routesController.updatedTime;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${busModel.routeID} - ${busModel.tripHeadsign}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Text(
              'Heading: ${busModel.directionText}\nLast Update: ${routesController.lastUpdate} seconds ago',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
