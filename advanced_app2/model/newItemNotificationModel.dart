import 'package:hive_flutter/hive_flutter.dart';

part 'newItemNotificationModel.g.dart';

@HiveType(typeId: 0)
class NewItemNotifcationModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime dateToShow;

  /// Those ids are no longer valid (3, 4)
  // @HiveField(3)
  // bool isIntervaled;
  // @HiveField(4)
  // double intervalDuration;
  @HiveField(5)
  bool isRepeated;
  @HiveField(11)
  bool hasAutoDelete;
  @HiveField(7)
  bool? isFavorite;

  @HiveField(9)
  int id;
  NewItemNotifcationModel(this.title, this.description, this.dateToShow,
      this.isRepeated, this.hasAutoDelete, this.isFavorite, this.id);
}
