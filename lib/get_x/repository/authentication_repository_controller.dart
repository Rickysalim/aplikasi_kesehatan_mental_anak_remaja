import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/utils/exceptions/signin_exception.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/utils/exceptions/signup_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryController extends GetxController {
  static AuthenticationRepositoryController get instance => Get.find();

  UserGuardsController _userGuardsController = Get.put(UserGuardsController());

  final _auth = FirebaseAuth.instance;


  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final err = SignInWithEmailAndPasswordFailureException.code(e.code);
      throw err;
    } catch (e) {
      final err = SignUpWithEmailAndPasswordFailureException();
      throw err;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user.additionalUserInfo!.isNewUser) {
        await _userGuardsController.user.currentUser
            ?.updateDisplayName(username);
      }
    } on FirebaseAuthException catch (e) {
      final err = SignUpWithEmailAndPasswordFailureException.code(e.code);
      throw err;
    } catch (e) {
      final err = SignUpWithEmailAndPasswordFailureException();
      throw err;
    }
  }
}
