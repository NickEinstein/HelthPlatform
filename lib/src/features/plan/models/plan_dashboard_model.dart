class PlanDashboardModel {
  final int daysCompleted;
  final int daysToGo;
  final double percentageOfGoalAchieved;
  final int goalsCompleted;
  final int productsReviewed;
  final int expertsEngaged;
  final int joinedCommunities;
  final int chpPointsAcquired;
  final int cheerleadersAndFriends;

  const PlanDashboardModel({
    required this.daysCompleted,
    required this.daysToGo,
    required this.percentageOfGoalAchieved,
    required this.goalsCompleted,
    required this.productsReviewed,
    required this.expertsEngaged,
    required this.joinedCommunities,
    required this.chpPointsAcquired,
    required this.cheerleadersAndFriends,
  });

  factory PlanDashboardModel.fromJson(Map<String, dynamic> json) {
    return PlanDashboardModel(
      daysCompleted: json['daysCompleted'],
      daysToGo: json['daysToGo'],
      percentageOfGoalAchieved: json['percentageOfGoalAchieved'],
      goalsCompleted: json['goalsCompleted'],
      productsReviewed: json['productsReviewed'],
      expertsEngaged: json['expertsEngaged'],
      joinedCommunities: json['joinedCommunities'],
      chpPointsAcquired: json['chpPointsAcquired'],
      cheerleadersAndFriends: json['cheerleadersAndFriends'],
    );
  }
}