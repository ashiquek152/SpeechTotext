import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthHelper {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //! SIGNIN WITH GOOGLE

  static Future<UserCredential> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential results = await _auth.signInWithCredential(credential);
    return results;
  }

  static Future<void> signout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    await FirebaseAuth.instance.currentUser?.reload();
    return;
  }
}
