import 'package:firebase_auth/firebase_auth.dart';


String ex1 = '';
String ex2 = '';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String first_name,
    required String last_name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      await user!.updateProfile(displayName: first_name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ex1 = "The password provided is too weak ";
      } else if (e.code == 'email-already-in-use') {
        ex1 = "An account with this email already exists. Please check again";
      } else {
        ex1 = e.toString();
      }
      return user;
    }
    return null;
  }

  static Future<User?> logInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContextcontext,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ex2 = "No account found for that email.";
      } else if (e.code == 'wrong-password') {
        ex2 = "Password entered is incorrect";
      }
    }
    return null;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}
