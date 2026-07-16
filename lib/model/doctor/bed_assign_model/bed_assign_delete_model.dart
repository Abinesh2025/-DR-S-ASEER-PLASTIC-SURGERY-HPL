import 'package:json_annotation/json_annotation.dart';

part 'bed_assign_delete_model.g.dart';

@JsonSerializable()
class BedAssignDelete {
  bool? success;
  String? message;

  BedAssignDelete({
    this.success,
    this.message,
  });

  factory BedAssignDelete.fromJson(Map<String, dynamic> json) => _$BedAssignDeleteFromJson(json);

  Map<String, dynamic> toJson() => _$BedAssignDeleteToJson(this);
}
