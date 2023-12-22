class SignUpWithEmailAndPasswordFailureException {
  final String message;
  final String code;
  SignUpWithEmailAndPasswordFailureException([this.code="Unknown code error", this.message = "An Unknown error occurred"]);

  factory SignUpWithEmailAndPasswordFailureException.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailureException(code, 'Password to weak try stronger password');
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailureException(code, 'Email already in use. please try other email');
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailureException(code, 'Invalid Email. please again');
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailureException(code, 'Operation not Allowed. please contact our support team');
      case 'user-disabled':
        return SignUpWithEmailAndPasswordFailureException(code, 'This user has been disabled. please contact our support team');
      default:
        return SignUpWithEmailAndPasswordFailureException();
    }
  }
}
