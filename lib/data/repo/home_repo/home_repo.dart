import 'package:zee_palm/export.dart';

mixin HomeRepo {
  Future<Either<AppError, OffersList>> getHomeData();
  Future<bool> submitOfferData(JobOfferModel data);
  Future<void> setUserStatus(bool status);
}
