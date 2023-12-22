class SignInWithEmailAndPasswordFailureException {
  String message;
  final String code;
  SignInWithEmailAndPasswordFailureException(
      [this.code = "Unknown code error",
      this.message = "An Unknown error occurred"]);

  factory SignInWithEmailAndPasswordFailureException.code(String code) {
    switch (code) {
      case 'invalid-credential':
        return SignInWithEmailAndPasswordFailureException(code, "Invalid Credential please try again");
      case 'invalid-email':
        return SignInWithEmailAndPasswordFailureException(code, "Invalid Email please try again");
      case 'wrong-password':
        return SignInWithEmailAndPasswordFailureException(code, "Invalid Password please try again");
      case 'user-not-found':
        return SignInWithEmailAndPasswordFailureException(code, "User not found. contact our team support");
      case 'user-disabled':
        return SignInWithEmailAndPasswordFailureException(code, "User disabled. contact our team support");
      default:
        return SignInWithEmailAndPasswordFailureException();
    }
  }
}
