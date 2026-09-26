// lib/view_models/controllers/auth_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/local/hive_boxes.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/app_alerts.dart';

class AuthController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ── Loading states ──────────────────────────────────────────
  final RxBool isLoginLoading  = false.obs;
  final RxBool isSignUpLoading = false.obs;
  final RxBool isForgotLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;

  // ── Password visibility ────────────────────────────────────
  final RxBool isPasswordVisible        = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  void togglePassword()        => isPasswordVisible.value        = !isPasswordVisible.value;
  void toggleConfirmPassword() => isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  // ══════════════════════════════════════════════════════════
  // SIGN UP
  // ══════════════════════════════════════════════════════════
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    // Validation
    if (name.trim().isEmpty) {
      AppAlerts.error('Please enter your name');
      return;
    }
    if (!GetUtils.isEmail(email.trim())) {
      AppAlerts.error('Please enter a valid email');
      return;
    }
    if (password.length < 8) {
      AppAlerts.error('Password must be at least 8 characters');
      return;
    }

    try {
      isSignUpLoading.value = true;

      // Firebase mein account banao
      final credential = await _auth.createUserWithEmailAndPassword(
        email:    email.trim(),
        password: password,
      );

      // Display name set karo
      await credential.user?.updateDisplayName(name.trim());

      // Hive mein save karo
      HiveBoxes.saveUser(
        uid:   credential.user!.uid,
        name:  name.trim(),
        email: email.trim(),
      );

      AppAlerts.success('Account created successfully!');

      // Personalize screen par jao — goal select karne
      Get.offAllNamed(RouteName.personalizeScreen);

    } on FirebaseAuthException catch (e) {
      AppAlerts.error(_getFirebaseError(e.code));
    } catch (e) {
      AppAlerts.error('Something went wrong. Please try again.');
    } finally {
      isSignUpLoading.value = false;
    }
  }

  // ══════════════════════════════════════════════════════════
  // LOGIN
  // ══════════════════════════════════════════════════════════
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // Validation
    if (!GetUtils.isEmail(email.trim())) {
      AppAlerts.error('Please enter a valid email');
      return;
    }
    if (password.isEmpty) {
      AppAlerts.error('Please enter your password');
      return;
    }

    try {
      isLoginLoading.value = true;

      final credential = await _auth.signInWithEmailAndPassword(
        email:    email.trim(),
        password: password,
      );

      // Hive mein save karo
      HiveBoxes.saveUser(
        uid:   credential.user!.uid,
        name:  credential.user?.displayName ?? '',
        email: credential.user!.email ?? '',
      );

      AppAlerts.success('Welcome back!');

      // Dashboard par jao
      Get.offAllNamed(RouteName.dashboard);

    } on FirebaseAuthException catch (e) {
      AppAlerts.error(_getFirebaseError(e.code));
    } catch (e) {
      AppAlerts.error('Something went wrong. Please try again.');
    } finally {
      isLoginLoading.value = false;
    }
  }

  // ══════════════════════════════════════════════════════════
  // GOOGLE SIGN IN
  // ══════════════════════════════════════════════════════════
  Future<void> signInWithGoogle() async {
    try {
      isGoogleLoading.value = true;

      // Google Sign In process start karo
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isGoogleLoading.value = false;
        return; // User ne cancel kar diya
      }

      // Auth details lelo
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Firebase credential create karo
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken:     googleAuth.idToken,
      );

      // Firebase mein sign in karo
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Hive mein save karo
        HiveBoxes.saveUser(
          uid:   user.uid,
          name:  user.displayName ?? '',
          email: user.email ?? '',
        );

        AppAlerts.success('Signed in with Google!');
        
        // Agar naya user hai toh personalize par bhejo, warna dashboard
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          Get.offAllNamed(RouteName.personalizeScreen);
        } else {
          Get.offAllNamed(RouteName.dashboard);
        }
      }

    } on FirebaseAuthException catch (e) {
      AppAlerts.error(_getFirebaseError(e.code));
    } catch (e) {
      AppAlerts.error('Google Sign In failed. Please try again.');
      print("Google Sign In Error: $e");
    } finally {
      isGoogleLoading.value = false;
    }
  }

  // ══════════════════════════════════════════════════════════
  // FORGOT PASSWORD
  // ══════════════════════════════════════════════════════════
  Future<void> forgotPassword({required String email}) async {
    if (!GetUtils.isEmail(email.trim())) {
      AppAlerts.error('Please enter a valid email');
      return;
    }

    try {
      isForgotLoading.value = true;

      await _auth.sendPasswordResetEmail(email: email.trim());

      AppAlerts.success('Reset link sent! Check your email.');

      // Login par wapas jao
      Get.offAllNamed(RouteName.loginScreen);

    } on FirebaseAuthException catch (e) {
      AppAlerts.error(_getFirebaseError(e.code));
    } catch (e) {
      AppAlerts.error('Something went wrong. Please try again.');
    } finally {
      isForgotLoading.value = false;
    }
  }

  // ══════════════════════════════════════════════════════════
  // LOGOUT
  // ══════════════════════════════════════════════════════════
  Future<void> logout() async {
    final confirm = await AppAlerts.confirm(
      title:       'Sign Out',
      message:     'Are you sure you want to sign out?',
      confirmText: 'Sign Out',
      isDanger:    true,
    );

    if (!confirm) return;

    await _auth.signOut();
    await _googleSignIn.signOut();
    HiveBoxes.clearUser();
    Get.offAllNamed(RouteName.loginScreen);
  }

  // ══════════════════════════════════════════════════════════
  // FIREBASE ERROR MESSAGES — user friendly
  // ══════════════════════════════════════════════════════════
  String _getFirebaseError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password is too weak. Use at least 8 characters.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'No internet connection.';
      case 'user-disabled':
        return 'This account has been disabled.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}