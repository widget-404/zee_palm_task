import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zee_palm/export.dart';

class HomeRepoImpl implements HomeRepo {
  final SharedPreferences _preferences;
  final FirebaseFirestore fireStore;

  HomeRepoImpl(
    this._preferences,
    this.fireStore,
  );

  @override
  Future<Either<AppError, OffersList>> getHomeData() async {
    try {
      String userId = _preferences.getString(constant.userId) ?? '';
      CollectionReference ref = fireStore.collection('Offers');
      final res = await ref.get();

      if (res.size > 0) {
        final allData = res.docs.map((doc) => doc.data()).toList();
        final data = OffersList.fromJson(allData);
        return Right(data);
      } else {
        return Left(AppError(title: 'Data not found'));
      }
    } catch (e) {
      print(e);
      return Left(AppError(title: 'Something went wrong, try again!'));
    }
  }

  @override
  Future<void> setUserStatus(bool status) async {
    try {
      String userId = _preferences.getString(constant.userId) ?? '';
      await fireStore
          .collection('chats')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          fireStore
              .collection('chats')
              .doc(doc.id)
              .collection('user_messages')
              .where('receiverId', isEqualTo: userId)
              .get()
              .then((data) {
            if (data.docs.isNotEmpty) {
              data.docs.forEach((element) {
                fireStore
                    .collection('chats')
                    .doc(doc.id)
                    .collection('user_messages')
                    .doc(element.id)
                    .update({'isOnline': status});
              });
            }
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<bool> submitOfferData(JobOfferModel data) async {
    try {
      String userId = _preferences.getString(constant.userId) ?? '';
      data.offererId = userId;
      data.offerId = userId + data.offerDate.toString();
      await fireStore.collection('Offers').doc(data.offerId).set(data.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
