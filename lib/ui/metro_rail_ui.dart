import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_task/Controllers/app_settings.dart';
import 'package:flutter_task/Controllers/metro_rail_controller.dart';
import 'package:flutter_task/Global/hex_color.dart';
import 'package:flutter_task/Models/metro_rail_model.dart';
import 'package:flutter_task/Widgets/custom_appbar.dart';
import 'package:flutter_task/ui/metro_rail_stations_ui.dart';
import 'package:get/get.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class MetroRail extends StatefulWidget {
  const MetroRail({super.key});

  @override
  State<MetroRail> createState() => _MetroRailState();
}

class _MetroRailState extends State<MetroRail> {
  final bool _loading = false;
  List<MetroRailModel> _metroRailsFilter = [];

  String search = '';

  @override
  Widget build(BuildContext context) {
    final MetroRailController metroRailProvider =
        Provider.of<MetroRailController>(context);
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Scaffold(
      backgroundColor: appSettingsController.isDark
          ? Theme.of(context).cardColor
          : Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light,
          // systemNavigationBarDividerColor: null,
          statusBarColor: HexColor(colorPurple),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0.0,
        backgroundColor: HexColor(colorPurple),
        centerTitle: false,
        title: Text(
          'Metro Rail',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.normal,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: IconButton(
                onPressed: () {
                  showToast('Coming soon',
                      context: context,
                      position: StyledToastPosition(align: Alignment.center));
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Gutter(),
          Container(
            height: 50,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
            width: Get.width,
            decoration: BoxDecoration(
                color: appSettingsController.isDark
                    ? Theme.of(context).cardColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: HexColor(colorGrey80),
                )),
            padding: const EdgeInsets.only(bottom: 5, top: 0, left: 15),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0, top: 10, left: 0),
                  child: Icon(Icons.search,
                      size: 24, color: HexColor(colorBlack60)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: appSettingsController.isDark
                                ? Colors.white
                                : Colors.black),
                        onChanged: (String value) {
                          setState(() {
                            search = value;
                            _metroRailsFilter = metroRailProvider.metroRails
                                .where((element) => element.displayName
                                    .toLowerCase()
                                    .contains(search.toLowerCase()))
                                .toList();
                            // if (value.length == 1) {

                            // } else {
                            //   search = value;
                            //   _metroRailsFilter = metroRailProvider.metroRails
                            //       .where((element) =>
                            //           element.displayName.contains(search))
                            //       .toList();
                            // }
                          });
                        },
                        scrollPadding: const EdgeInsets.all(0),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(0),
                            hintText: 'Search Line...',
                            border: InputBorder.none,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: HexColor(colorBlack60),
                                    fontSize: 12))))
              ],
            ),
          ),
          _loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: search.isNotEmpty
                      ? ListView.builder(
                          itemCount: _metroRailsFilter.length,
                          itemBuilder: (context, index) {
                            return cardUi(_metroRailsFilter[index]);
                          })
                      : ListView.builder(
                          itemCount: metroRailProvider.metroRails.length,
                          itemBuilder: (context, index) {
                            final metroRail =
                                metroRailProvider.metroRails[index];
                            return cardUi(metroRail);
                          },
                        ))
        ],
      ),
    );
  }

  cardUi(MetroRailModel metroRail) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
      child: InkWell(
        onTap: () {
          Get.to(() => MetroRailStationsUi(
                metroRailModel: metroRail,
                secondColor: _checkDisplayColor(metroRail.displayName).last,
                color: _checkDisplayColor(metroRail.displayName).first,
              ));
        },
        child: Container(
          margin:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: _checkDisplayColor(metroRail.displayName).last,
                    border: Border.all(
                      color: _checkDisplayColor(metroRail.displayName).first,
                      width: 5,
                    )),
                // padding: const EdgeInsets.all(5),
                // child: Center(
                //   child: Container(
                //     height: 35,
                //     width: 35,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(500),
                //       color: _checkDisplayColor(metroRail.displayName).last,
                //     ),
                //   ),
                // ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${metroRail.displayName} Line',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: appSettingsController.isDark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _checkDisplayColor(String displayName) {
    List<Color> color = [];
    if (displayName == 'Blue') {
      color.add(HexColor(colorBlue100));
      color.add(HexColor(colorBlue20));
    } else if (displayName == 'Green') {
      color.add(HexColor(colorGreen100));
      color.add(HexColor(colorGreen20));
    } else if (displayName == 'Orange') {
      color.add(HexColor(colorOrange100));
      color.add(HexColor(colorOrange20));
    } else if (displayName == 'Red') {
      color.add(HexColor(colorRed100));
      color.add(HexColor(colorRed20));
    } else if (displayName == 'Silver') {
      color.add(HexColor(colorGrey100));
      color.add(HexColor(colorGrey20));
    } else if (displayName == 'Yellow') {
      color.add(HexColor(colorYellow100));
      color.add(HexColor(colorYellow20));
    }
    return color;
  }
}
