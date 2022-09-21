import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

Future<void> initializeUseCasesDependencies() async {
  final RepoDependencies repoDependencies = RepoDependencies();
  await repoDependencies.init();
  await repoDependencies.initializeRepoDependencies();

  Get.lazyPut<AuthUseCase>(
    () => AuthUseCase(
      Get.find<AuthRepo>(),
    ),
    fenix: true,
  );
  Get.lazyPut<MessageUseCase>(
    () => MessageUseCase(
      Get.find(),
    ),
    fenix: true,
  );
  Get.lazyPut<HomeUseCase>(
    () => HomeUseCase(
      Get.find(),
    ),
    fenix: true,
  );
}
