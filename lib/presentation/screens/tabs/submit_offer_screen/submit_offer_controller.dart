import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class SubmitOfferController extends GetxController
    with StateMixin<SubmitOfferPage> {
  final HomeUseCase useCase;

  SubmitOfferController(this.useCase);

  TextEditingController budgetController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isActive = false.obs;

  late JobOfferModel data;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> submitOffer() async {
    if (isActive.value) {
      isLoading.value = true;
      JobOfferModel data = JobOfferModel(
        offerId: '',
        offererId: '',
        budget: double.parse(budgetController.text),
        deliveryTime: int.parse(deliveryTimeController.text),
        description: descriptionController.text,
        offerDate: DateTime.now(),
      );
      final res = await useCase.submitOffer(data);
      if (res) {
        descriptionController.clear();
        budgetController.clear();
        deliveryTimeController.clear();
        statusController.clear();
        setButtonStatus();
        isLoading.value = false;
        showToast('Offer Submitted Successfully!', !res);
      } else {
        showToast('Something went wrong, try again latter!', !res);
      }
    }
  }

  void setButtonStatus() {
    isActive.value = descriptionController.text.isNotEmpty &&
        budgetController.text.isNotEmpty &&
        deliveryTimeController.text.isNotEmpty &&
        statusController.text.isNotEmpty;
  }
}
