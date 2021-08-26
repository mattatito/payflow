class LoginStatus {
  final bool loading;
  final String error;
  final bool success;

  LoginStatus({
    this.loading = false,
    this.error = "",
    this.success = false,
  });

  factory LoginStatus.success() => LoginStatus(loading: false, success: true);
  factory LoginStatus.loading() => LoginStatus(loading: true);
  factory LoginStatus.error(String message) =>
      LoginStatus(error: message, loading: false);
}
