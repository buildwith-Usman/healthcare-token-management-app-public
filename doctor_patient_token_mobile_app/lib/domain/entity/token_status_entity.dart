class TokenStatusEntity {
  final List<TokenStatus> tokens;
  final String shift;
  final String date;
  final String day;

  TokenStatusEntity({
    required this.tokens,
    required this.shift,
    required this.date,
    required this.day
  });
}

class TokenStatus {
  final int number;
  late final String status;
  final int numberOfPatients;
  final int tokenId;

  TokenStatus({
    required this.number,
    required this.status,
    required this.numberOfPatients,
    required this.tokenId
  });
}
