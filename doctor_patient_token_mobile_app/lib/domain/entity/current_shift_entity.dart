class CurrentShiftEntity {
  String? shift;
  String? date;
  final bool? bookingEnable;
  final String? message;
  final String? userTokenNumber;
  final String? userTokenStatus;
  final String? day;
  final bool? currentShiftDisable;

  CurrentShiftEntity(
      {this.shift,
      this.date,
      this.bookingEnable,
      this.message,
      this.userTokenNumber,
      this.userTokenStatus,
      this.day,
      this.currentShiftDisable});
}
