import 'package:flutter/material.dart';
import 'package:flutter_task/Global/hex_color.dart';
import 'package:flutter_task/Models/buses_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../Controllers/app_settings.dart';
import '../Controllers/routes_controller.dart';

class CustomInfo extends StatefulWidget {
  final BusesModel busModel;
  const CustomInfo({super.key, required this.busModel});

  @override
  State<CustomInfo> createState() => _CustomInfoState();
}

class _CustomInfoState extends State<CustomInfo> {
  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    final RoutesController routesController =
        Provider.of<RoutesController>(context);

    final fifteenAgo =
        DateTime.now().subtract(Duration(seconds: routesController.lastUpdate));
    return Container(
      decoration: BoxDecoration(
        color: appSettingsController.isDark
            ? Theme.of(context).cardColor
            : Colors.white,
        border: Border.all(color: HexColor(colorGrey80)),
        borderRadius: BorderRadius.circular(8),
      ),
      // width: double.infinity,
      // height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.busModel.routeID} - ${widget.busModel.tripHeadsign}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              'Heading: ${widget.busModel.directionText}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            Text(
              'Last Update: ${routesController.lastUpdate} seconds ago',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
