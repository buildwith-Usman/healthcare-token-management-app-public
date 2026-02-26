import 'package:json_annotation/json_annotation.dart';

part 'start_check_up_response.g.dart';

@JsonSerializable()
class StartCheckUpResponse {

  @JsonKey(name: 'shift')
  final String? shift;

    @JsonKey(name: 'date')
  final String? date;

  StartCheckUpResponse({
    this.shift,
    this.date
  });

  factory StartCheckUpResponse.fromJson(Map<String, dynamic> json) =>
      _$StartCheckUpResponseFromJson(json);

}
