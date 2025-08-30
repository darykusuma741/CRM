abstract class LoginResultState {}

class WaitingForApprovalLoginResultState extends LoginResultState {}

class RejectLoginResultState extends LoginResultState {}

class FinalLoginResultState extends LoginResultState {}