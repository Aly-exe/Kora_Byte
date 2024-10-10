abstract class GetMatchesStates {}

class GetMatchesInitialState extends GetMatchesStates {}

class LoadingGetMatchesState extends GetMatchesStates {}
class SuccessGetMatchesState extends GetMatchesStates {}

class FailureGetMatchesState extends GetMatchesStates {
  final String errorMessage;

  FailureGetMatchesState(this.errorMessage);
}
class LoadingMatchDetailsState extends GetMatchesStates{}
class SuccessGetMatchDetailsState extends GetMatchesStates{}
class FailureGetMatchDetailsState extends GetMatchesStates{
  final String errorMessage;

  FailureGetMatchDetailsState(this.errorMessage);
}
