// Define All App Level Enum here
enum Filter { token, name, date }

enum ScreenName { signUp, login, forgotPassword, otp, password, setting }

enum UserRole {
  patient,
  doctor,
  reception,
}

enum TokenStatusEnum {
  hold,
  free,
  paymentRequired,
  booked,
  checked,
  pending,
  cancelled,
  skipped,
}

enum BottomSheetType {
  changeEmail,
  changePhone,
  changePassword,
}

enum Shift { morning, evening, all }
