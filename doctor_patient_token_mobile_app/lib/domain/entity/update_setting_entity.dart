class UpdateSettingEntity {
  const UpdateSettingEntity({
    this.shift,
    this.shiftDate,
    this.morningShiftStartTime,
    this.morningShiftEndTime,
    this.eveningShiftStartTime,
    this.eveningShiftEndTime,
    this.shiftDisablePattern
  });

  final String? shift;
  final String? shiftDate;
  final String? morningShiftStartTime;
  final String? morningShiftEndTime;
  final String? eveningShiftStartTime;
  final String? eveningShiftEndTime;
  final String? shiftDisablePattern;
}
