import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class HomeController extends GetxController with StateMixin<HomePage> {
  final HomeUseCase useCase;

  HomeController(this.useCase);

  late List<JobOfferModel> data;

  @override
  Future<void> onInit() async {
    change(null, status: RxStatus.loading());
    await useCase.getHomeData();
    if (useCase.offersList.data.isNotEmpty) {
      data = useCase.offersList.data;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
    super.onInit();
  }

  listenDataOnUpdate() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('Offers');
    ref.snapshots().listen(
      (event) {
        final allData = event.docs.map((doc) => doc.data()).toList();
        if (allData.isNotEmpty) {
          final updatedData = OffersList.fromJson(allData);
          data = updatedData.data;
          update();
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  setStatus(bool online) {
    useCase.setUserStatus(online);
  }
}
