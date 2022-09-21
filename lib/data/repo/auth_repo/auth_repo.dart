import 'package:zee_palm/export.dart';

mixin AuthRepo {
  Future<Either<AppError, dynamic>> googleLogin();

  Future<Either<AppError, dynamic>> phoneLogin(String number);

  Future<Either<AppError, dynamic>> verifyOTP(
    String smsCode,
    bool isFromSettings,
  );

  Future<Either<AppError, dynamic>> resendOTP(String number);

  Future<Either<AppError, dynamic>> facebookLogin();
}
