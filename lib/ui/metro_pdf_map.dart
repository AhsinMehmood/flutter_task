import 'package:flutter/material.dart';
import 'package:flutter_task/Controllers/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MetroPdfMap extends StatelessWidget {
  const MetroPdfMap({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            appSettingsController.isDark ? Colors.black : Colors.white,
        title: Text(
          'Metro Map',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                color:
                    appSettingsController.isDark ? Colors.white : Colors.black,
              ),
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              size: 21,
              color: appSettingsController.isDark ? Colors.white : Colors.black,
            )),
      ),
      backgroundColor:
          appSettingsController.isDark ? Colors.black : Colors.white,
      body: SfPdfViewer.asset(
        'assets/map_pd.pdf',
      ),
    );
  }
}
