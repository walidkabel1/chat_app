part of 'logincubit.dart';

@immutable
abstract class loginstate {}

final class loginInitial extends loginstate {}

final class loginloading extends loginstate {}

final class loginSucess extends loginstate {}

final class loginFailure extends loginstate {
  String errMessage;

  loginFailure({required this.errMessage});
}
