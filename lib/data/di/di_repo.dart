import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zee_palm/export.dart';

class RepoDependencies {
  late NetworkHelper _networkHelper;
  late EndPoints _endPoints;
  late SharedPreferences _sharedPreferences;
  late FirebaseFirestore _fireStore;

  Future init() async {
    _endPoints = EndPoints();
    _networkHelper = NetworkHelperImpl();
    _sharedPreferences = await SharedPreferences.getInstance();
    _fireStore = FirebaseFirestore.instance;
  }

  initializeRepoDependencies() {
    Get.lazyPut<SharedPreferences>(
      () => _sharedPreferences,
      fenix: true,
    );
    Get.lazyPut<AuthRepo>(
      () => AuthRepoImpl(
        _sharedPreferences,
        _fireStore,
      ),
      fenix: true,
    );
    Get.lazyPut<MessageRepo>(
      () => MessageRepoImpl(
        _sharedPreferences,
        _fireStore,
      ),
      fenix: true,
    );
    Get.lazyPut<HomeRepo>(
      () => HomeRepoImpl(
        _sharedPreferences,
        _fireStore,
      ),
      fenix: true,
    );
  }
}
