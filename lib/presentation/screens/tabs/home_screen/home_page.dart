import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class HomePage extends GetView<HomeController> with WidgetsBindingObserver {
  const HomePage({Key? key}) : super(key: key);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        controller.setStatus(true);
        break;
      case AppLifecycleState.inactive:
        controller.setStatus(false);
        break;
      case AppLifecycleState.paused:
        controller.setStatus(false);
        break;
      case AppLifecycleState.detached:
        controller.setStatus(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    return Scaffold(
      backgroundColor: colors.naturalWhite,
      appBar: AppBar(
        backgroundColor: colors.naturalWhite,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Zee Palm',
          style: textStyles.bodyRegular,
        ),
      ),
      body: controller.obx(
        (state) => getBody(),
        onLoading: LoadingState(),
        onEmpty: EmptyState(),
      ),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            'Active Offers',
            style: textStyles.headingRegular,
          ),
          verticalSpacer(10),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  return OfferWidget(controller.data[index]);
                }),
          )
        ],
      ),
    );
  }
}
