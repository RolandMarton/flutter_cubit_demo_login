enum LoginStatus {
  initial(message: 'Enter credentials'),
  loading(message: 'Logging in...'),
  success(message: 'Login successful'),
  failure(message: 'Invalid credentials');

  final String message;
  const LoginStatus({required this.message});
}