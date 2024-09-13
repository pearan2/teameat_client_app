enum TEAction {
  viewFoodLogGuide(resetDuration: Duration(seconds: 5)); // test 용으로 ...

  const TEAction({required this.resetDuration});

  final Duration resetDuration;
}

abstract class INeedActionRepository {
  bool isNeedTo(TEAction action);
  void act(TEAction action);
}
