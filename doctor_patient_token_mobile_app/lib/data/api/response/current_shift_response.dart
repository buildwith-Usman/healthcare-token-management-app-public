import 'package:json_annotation/json_annotation.dart';

part 'current_shift_response.g.dart';

@JsonSerializable()
class CurrentShiftResponse {
  @JsonKey(name: "shift")
  final String? shift;

  @JsonKey(name: "date")
  final String? date;

  @JsonKey(name: "booking_enable")
  final bool? bookingEnable;

  @JsonKey(name: "user_token_number")
  final String? userTokenNumber;

  @JsonKey(name: "user_token_status")
  final String? userTokenStatus;

  @JsonKey(name: "day")
  final String? day;

  @JsonKey(name: "shift_status")
  final String? shiftStatus;

  @JsonKey(name: "current_shift_disable")
  final bool? currentShiftDisable;

  @JsonKey(name: "message")
  final String? message;

  CurrentShiftResponse(
      {this.shift,
      this.date,
      this.bookingEnable,
      this.userTokenNumber,
      this.userTokenStatus,
      this.day,
      this.shiftStatus,
      this.currentShiftDisable,
      this.message});

  factory CurrentShiftResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentShiftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentShiftResponseToJson(this);
}
