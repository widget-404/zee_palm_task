import 'package:zee_palm/export.dart';

class AuthUseCase {
  final AuthRepo repo;

  AuthUseCase(this.repo);

  UserLoginModel user = UserLoginModel();

  Future<Either<AppError, AppSuccess>> loginWithGoogle() async {
    try {
      final either = await repo.googleLogin();
      return either.fold(
        (error) => Left(error),
        (data) {
          user = data;
          print(user);
          return Right(AppSuccess());
        },
      );
    } catch (error) {
      return Left(AppError(title: error.toString()));
    }
  }

  Future<Either<AppError, String>> loginWithPhone(String number) async {
    try {
      final either = await repo.phoneLogin(number);
      return either.fold(
        (error) => Left(AppError()),
        (data) => Right(data),
      );
    } catch (error) {
      return Left(AppError(title: error.toString()));
    }
  }

  Future<Either<AppError, bool>> verifyOtp(
      String otp, bool isFromSettings) async {
    try {
      final either = await repo.verifyOTP(otp, isFromSettings);

      return either.fold(
        (error) => Left(error),
        (data) {
          if (data is UserLoginModel) {
            return Right(true);
          }
          return const Right(true);
        },
      );
    } catch (error) {
      return Left(AppError(title: error.toString()));
    }
  }
}
