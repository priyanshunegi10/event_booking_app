import 'package:firebase_auth/firebase_auth.dart';

class SignUp {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }


  
}
