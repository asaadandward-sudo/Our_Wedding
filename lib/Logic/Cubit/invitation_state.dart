abstract class InvitationState {}

class InvitationInitial extends InvitationState{}

class InvitationLoading extends InvitationState{}

class InvitationDone extends InvitationState{}

class InvitationError extends InvitationState{
  final String message;
  InvitationError(this.message);
}


