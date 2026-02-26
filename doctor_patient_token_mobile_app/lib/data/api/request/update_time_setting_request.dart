import 'package:json_annotation/json_annotation.dart';

part 'update_time_setting_request.g.dart';

@JsonSerializable()
class UpdateTimeSettingRequest {
  @JsonKey(name: "morning_shift_start_time", includeIfNull: false)
  final String? morningShiftStartTime;

  @JsonKey(name: "morning_shift_end_time", includeIfNull: false)
  final String? morningShiftEndTime;

  @JsonKey(name: "evening_shift_start_time", includeIfNull: false)
  final String? eveningShiftStartTime;

  @JsonKey(name: "evening_shift_end_time", includeIfNull: false)
  final String? eveningShiftEndTime;

  @JsonKey(name: "shift_disable_pattern", includeIfNull: false)
  final String? shiftDisablePattern;

  UpdateTimeSettingRequest(
      {this.morningShiftStartTime,
      this.morningShiftEndTime,
      this.eveningShiftStartTime,
      this.eveningShiftEndTime,
      this.shiftDisablePattern
      });

  // Factory method for JSON deserialization
  factory UpdateTimeSettingRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTimeSettingRequestFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$UpdateTimeSettingRequestToJson(this);
}
