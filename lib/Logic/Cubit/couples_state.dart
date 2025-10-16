import 'package:weeding_invitation/Data/Models/admin_user.dart';
import 'package:weeding_invitation/Data/Models/guest.dart';

abstract class CouplesState {}

class CouplesInitial extends CouplesState {}

class CouplesLoading extends CouplesState {
  final bool showDialog;
  CouplesLoading({this.showDialog = true});
}

class CouplesAuthenticated extends CouplesState {
  final AdminUser admin;
  CouplesAuthenticated(this.admin);
}

class CouplesUnauthenticated extends CouplesState {}

class CouplesGuestsLoaded extends CouplesState {
  final List<Guest> guests;
  CouplesGuestsLoaded(this.guests);
}

class CouplesError extends CouplesState {
  final String message;
  CouplesError(this.message);
}
