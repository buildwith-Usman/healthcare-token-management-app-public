class AppointmentHistoryEntity {
  final int? id;
  final String? date;
  final int? tokenNumber;
  final int? tokenId;
  final String? name;
  final String? prescription;
  final String? status;
  final int? numberOfPatients;
  final String? shift;
  final String? type;

  AppointmentHistoryEntity({
    required this.id,
    required this.date,
    required this.tokenNumber,
    required this.name,
    required this.tokenId,
    required this.prescription,
    required this.status,
    required this.numberOfPatients,
    required this.shift,
    required this.type
  });
}

class AppointmentHistoryPagingEntity {
  final List<AppointmentHistoryEntity> appointmentHistoryEntity;
  final int? totalAppointments;
  final PaginationEntity? pagination;

  AppointmentHistoryPagingEntity({
    required this.appointmentHistoryEntity,
    required this.totalAppointments,
    this.pagination,
  });
}

class PaginationEntity {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  PaginationEntity({this.currentPage, this.lastPage, this.perPage, this.total});
}

