import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zee_palm/export.dart';

class AuthRepoImpl implements AuthRepo {
  final SharedPreferences _preferences;
  final FirebaseFirestore fireStore;

  AuthRepoImpl(
    this._preferences,
    this.fireStore,
  );

  String verificationId = '';

  @override
  Future<Either<AppError, dynamic>> facebookLogin() async {
    final fb = FacebookLogin();

// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
      FacebookPermission.userFriends,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Access token: ${accessToken?.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! You ID: ${profile?.userId}');
        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        // SocialLogInBody socialLogInBody = SocialLogInBody(
        //     fName: profile.firstName,
        //     lName: profile.lastName,
        //     email: email,
        //     medium: 'facebook',
        //     phone: '',
        //     token: res.accessToken.token.toString(),
        //     uniqueId: profile.userId);
        // return socialLogInBody;
        break;
      case FacebookLoginStatus.cancel:
        return Left(
          AppError(
            title: res.status.toString(),
            description: res.error.toString(),
          ),
        );
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        return Left(
          AppError(
            title: res.status.toString(),
            description: res.error.toString(),
          ),
        );
    }
    return Left(
      AppError(
        title: res.status.toString(),
        description: res.error.toString(),
      ),
    );
  }

  @override
  Future<Either<AppError, dynamic>> googleLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication;
      if (googleSignInAccount != null) {
        googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // handle the error here
          } else if (e.code == 'invalid-credential') {
            // handle the error here
          }
        } catch (e) {
          print(e);
          return Left(
            AppError(
              title: e.toString(),
            ),
          );
        }
        _preferences.setString(constant.userId, user?.uid ?? '');
        _preferences.setString(constant.userName, user?.displayName ?? '-');
        return Right(
          UserLoginModel(
            userID: user?.uid ?? '',
            name: user?.displayName ?? '',
            email: user?.email ?? "",
            phone: user?.phoneNumber ?? '',
            image: user?.photoURL ?? '',
          ),
        );
      } else {
        return Left(
          AppError(
            title: 'something went wrong',
          ),
        );
      }
    } catch (e) {
      print(e);
      return Left(
        AppError(
          title: e.toString(),
        ),
      );
    }
    return Left(
      AppError(
        title: 'something went wrong',
      ),
    );
  }

  @override
  Future<Either<AppError, dynamic>> phoneLogin(String number) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    _verificationCompleted(phoneAuthCredential) async {}

    _verificationFailed(authException) {
      print(authException.message);
    }

    void codeSent(String verification) {
      verificationId = verification;
    }

    _codeAutoRetrievalTimeout(String verificationId) {
      Future.delayed(const Duration(seconds: 30));
    }

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: (verificationId, [forceResendingToken]) =>
            codeSent(verificationId),
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 119),
      );
      return Right(verificationId);
    } catch (e) {
      return Left(AppError(title: e.toString()));
    }
  }

  @override
  Future<Either<AppError, dynamic>> resendOTP(String number) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _verificationCompleted(phoneAuthCredential) async {
      // final value = await _auth.signInWithCredential(phoneAuthCredential);
      // if (value.user != null) {
      // final res = await checkForDisplayName();
      // Future.delayed(const Duration(seconds: 1));
      // if (res.isRight()) {
      /// user name is present
      // navigateToHome();
      // } else {
      /// username is not available
      // navigateToRegister();
      // }
      // }
    }

    _verificationFailed(authException) {
      // view.hideProgressBar();
      // view.showErrorMessage(
      //     AppError(title: FAILED_PHONE_NUMBER_AUTHENTICATION));
    }

    void _codeSent(String verificationId) {
      Future.delayed(const Duration(seconds: 1));
      // navigateToOTPVerificationPage(verificationId);
    }

    _codeAutoRetrievalTimeout(String verificationId) {
      Future.delayed(const Duration(seconds: 1));
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: (verificationId, [resendToken]) => _codeSent(verificationId),
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 119),
      );

      return const Right(true);
    } catch (e) {
      return Left(AppError(title: e.toString()));
    }
  }

  @override
  Future<Either<AppError, dynamic>> verifyOTP(
    String smsCode,
    bool isFromSettings,
  ) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      dynamic user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        if (!isFromSettings) {
          _preferences.setString('user_id', user?.uid ?? '');

          return Right(
            UserLoginModel(
              userID: user?.uid ?? '',
              name: user?.displayName ?? '',
              email: user?.email ?? "",
              phone: user?.phoneNumber ?? '',
              image: user?.photoURL ?? '',
            ),
          );
        }
        return Right(true);
      } else {
        return Left(AppError());
      }
    } catch (e) {
      if (e is FirebaseException) {
        return Left(
          AppError(title: e.code.toString(), description: e.message.toString()),
        );
      } else {
        return Left(
          AppError(title: e.toString()),
        );
      }
    }
  }
}
