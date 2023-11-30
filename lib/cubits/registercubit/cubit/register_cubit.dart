import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:chat_app/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> signup(
      {required String myemail, required String mypassword}) async {
    emit(registerloading());

    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: myemail!,
        password: mypassword!,
      );
      emit(registersucess());
    } on Exception catch (e) {
      emit(registerfaliure(errMessage: 'THIS EMAIL IS ALREADY IN USE'));
    }
  }
}
