part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class registerloading extends RegisterState {}

final class registersucess extends RegisterState {}

final class registerfaliure extends RegisterState {
  String errMessage;

  registerfaliure({required this.errMessage});
}
