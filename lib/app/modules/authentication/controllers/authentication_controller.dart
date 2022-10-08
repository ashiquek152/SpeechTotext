import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ninjastudy/app/data/firebase/firebase_auth_helper.dart';
import 'package:ninjastudy/app/data/firebase/firebase_db_helper.dart';
import 'package:ninjastudy/app/models/user_model.dart';

class AuthenticationController extends GetxController {
  bool isLoading = false;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  RxString connectionType = "".obs;
  final fireBaseDBHelper =FireBaseDBHelper();


  @override
  void onInit() {
    getConnectionStatus();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(getConnectionType);
    super.onInit();
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  Future getConnectionStatus() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await connectivity.checkConnectivity();
      log(connectivityResult.toString());
      getConnectionType(connectivityResult);
    } catch (e) {
      log(e.toString());
    }
  }

  getConnectionType(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      connectionType.value = "wifi";
    } else if (connectivityResult == ConnectivityResult.mobile) {
      connectionType.value = "mobile";
    } else if (connectivityResult == ConnectivityResult.none) {
      connectionType.value = "No Connection";
    }
  }

  //! //////////////////////////////////////////////////////////////////
  
  Future<void> signInWithGoogle() async {
    isLoading = true;
    update();
    try {
      final UserCredential userCredential = await AuthHelper.signInWithGoogle();
      if (userCredential.user != null) {
        final User user = userCredential.user!;

        await fireBaseDBHelper.createUserInCollection(
          userModel: UserModel(
            userName: user.displayName!,
            userUid: user.uid,
            userEmail: user.email!,
          ),
        );
      }
      isLoading = false;
      update();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();
      final erroMessage = e.message;
      log("FIREBASE EXCEPTION  $erroMessage");
      // errorSnackBar(erroMessage);
    } catch (e) {
      isLoading = false;
      update();
      final message = "Somthing went wrong $e";
      // errorSnackBar(message);
      log(message.toString());
    }
    isLoading = false;
    update();
  }
}
