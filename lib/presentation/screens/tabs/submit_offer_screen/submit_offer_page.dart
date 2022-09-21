import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class SubmitOfferPage extends GetView<SubmitOfferController> {
  const SubmitOfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacer(10),
            Text(
              'Description',
              style: textStyles.bodyRegular,
            ),
            verticalSpacer(10),
            Container(
              child: CustomTextField(
                controller: controller.descriptionController,
                onChanged: (value) {
                  controller.setButtonStatus();
                },
                maxLines: 5,
              ),
            ),
            verticalSpacer(20),
            Text(
              'Budget',
              style: textStyles.bodyRegular,
            ),
            verticalSpacer(10),
            CustomTextField(
              controller: controller.budgetController,
              onChanged: (value) {
                controller.setButtonStatus();
              },
              inputType: TextInputType.number,
              hintText: '\$',
            ),
            verticalSpacer(20),
            Text(
              'deliver Time',
              style: textStyles.bodyRegular,
            ),
            verticalSpacer(10),
            CustomTextField(
              controller: controller.deliveryTimeController,
              onChanged: (value) {
                controller.setButtonStatus();
              },
              inputType: TextInputType.number,
              hintText: 'in days',
            ),
            verticalSpacer(20),
            Text(
              'Status',
              style: textStyles.bodyRegular,
            ),
            verticalSpacer(10),
            CustomTextField(
              controller: controller.statusController,
              onChanged: (value) {
                controller.setButtonStatus();
              },
            ),
            verticalSpacer(40),
            Obx(() {
              return LargeButton(
                text: 'Submit',
                onPressed: controller.submitOffer,
                isLoading: controller.isLoading.value,
                isEnable: controller.isActive.value,
              );
            }),
          ],
        ),
      ),
    );
  }
}
