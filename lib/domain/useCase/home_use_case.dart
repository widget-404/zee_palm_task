import 'package:zee_palm/export.dart';

class HomeUseCase {
  final HomeRepo repo;

  HomeUseCase(this.repo);

  OffersList _offersList = OffersList([]);

  Future<bool> getHomeData() async {
    try {
      setUserStatus(true);
      final res = await repo.getHomeData();
      return res.fold((error) {
        return false;
      }, (data) {
        _offersList = data;
        return true;
      });
    } catch (error) {
      return false;
    }
  }

  Future<bool> submitOffer(JobOfferModel data) async {
    try {
      final res = await repo.submitOfferData(data);
      if (res) {
        await getHomeData();
      }
      return res;
    } catch (error) {
      return false;
    }
  }

  Future<void> setUserStatus(bool status) async {
    await repo.setUserStatus(status);
  }

  OffersList get offersList => _offersList;
}
