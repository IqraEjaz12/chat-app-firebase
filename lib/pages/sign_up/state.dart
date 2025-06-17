import 'package:get/get.dart';

class SignUpState {
  // Observable variables for form state
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var agreedToTerms = false.obs;
  var isFormValid = false.obs;

  // Error messages
  var nameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  // Form completion status
  var isNameValid = false.obs;
  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;
  var isConfirmPasswordValid = false.obs;

  void clearErrors() {
    nameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
  }

  void updateFormValidity() {
    isFormValid.value = isNameValid.value &&
        isEmailValid.value &&
        isPasswordValid.value &&
        isConfirmPasswordValid.value &&
        agreedToTerms.value;
  }
}
