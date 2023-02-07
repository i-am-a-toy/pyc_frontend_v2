String? requiredStringValidator(String? val) {
  if (val == null || val.trim().isEmpty) {
    return '필수 입력입니다.';
  }
  return null;
}
