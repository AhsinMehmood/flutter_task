import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task/Controllers/app_settings.dart';
import 'package:flutter_task/Global/hex_color.dart';
import 'package:flutter_task/ui/metro_rail_ui.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'live_map_ui.dart';
import 'more_ui.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSettingsController settingsController =
        Provider.of<AppSettingsController>(context);
    return Scaffold(
        body: IndexedStack(
          index: settingsController.tabIndex,
          children: [
            Container(),
            Container(),
            const MetroRail(),
            Container(),
            const MoreUi(),
          ],
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              settingsController.isDark ? Colors.black : Colors.white,
          selectedItemColor: HexColor(colorPurple),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedIconTheme: IconThemeData(
            color: HexColor(colorPurple),
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 10,
            color: HexColor(colorPurple),
          ),
          currentIndex: settingsController.tabIndex,
          onTap: (int index) {
            if (index == 3) {
              Get.to(() => const LiveMapUi());
            } else {
              settingsController.changeTabIndex(index);
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/favorite.svg',
                  height: 24,
                  width: 24,
                  // ignore: deprecated_member_use
                  color: settingsController.tabIndex == 0
                      ? HexColor(colorPurple)
                      : null,
                ),
                label: 'Favorites'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/directions_bus.svg',
                  height: 24,
                  width: 24,
                  // ignore: deprecated_member_use
                  color: settingsController.tabIndex == 1
                      ? HexColor(colorPurple)
                      : null,
                ),
                label: 'Bus Routes'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/directions_subway.svg',
                  height: 24,
                  width: 24,
                  // ignore: deprecated_member_use
                  color: settingsController.tabIndex == 2
                      ? HexColor(colorPurple)
                      : null,
                ),
                label: 'Metro Rail'),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/pin_drop.svg',
                height: 24,
                width: 24,
                // ignore: deprecated_member_use
                color: settingsController.tabIndex == 3
                    ? HexColor(colorPurple)
                    : null,
              ),
              label: 'Live Map',
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/notes.svg',
                  // ignore: deprecated_member_use
                  color: settingsController.tabIndex == 4
                      ? HexColor(colorPurple)
                      : null,
                  height: 24,
                  width: 24,
                ),
                label: 'More'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}


// Card(
//         color: Colors.white,
//         elevation: 4.0,
//         child: Container(
//           height: 60,
//           margin: const EdgeInsets.only(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             top: 10,
//           ),
//           padding:
//               const EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 4),
//           width: Get.width,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 50,
//                 width: 60,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset('assets/favourite_icon.svg'),
//                     Text(
//                       'Favourites',
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 10,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//                 width: 60,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset('assets/directions_bus.png'),
//                     Text(
//                       'Bus Routes',
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 10,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//                 width: 60,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       'assets/directions_subway.svg',
//                       // colorFilter: ,
//                       // color: HexColor(colorPurple),
//                     ),
//                     Text(
//                       'Metro Rail',
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 10,
//                             color: HexColor(colorPurple),
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//                 width: 60,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset('assets/pin_drop.png'),
//                     Text(
//                       'Live Map',
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 10,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//                 width: 60,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset('assets/notes.png'),
//                     Text(
//                       'More',
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 10,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),