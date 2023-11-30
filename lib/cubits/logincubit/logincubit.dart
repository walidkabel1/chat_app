import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'loginstate.dart';

class Logincubit extends Cubit<loginstate> {
  Logincubit() : super(loginInitial());
  //String? myemail, mypassword;
  Future<void> login(
      {required String myemail, required String mypassword}) async {
    emit(loginloading());
    try {
      var auth = FirebaseAuth.instance;
      final credential = await auth.signInWithEmailAndPassword(
          email: myemail, password: mypassword);

      emit(loginSucess());
    } catch (ex) {
      emit(loginFailure(errMessage: 'WRONG EMAIL OR PASSWORD'));
    }
  }
}
