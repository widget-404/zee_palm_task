class AppError {
  final String title;
  final String description;

  AppError({this.title = "", this.description = ""});

  @override
  int get hashCode => title.hashCode ^ description.hashCode;

  factory AppError.copy({String title = "", String description = ""}) {
    return AppError(title: title, description: description);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppError &&
          other.title == title &&
          other.description == description);
}

class AppSuccess {
  Object? data;

  AppSuccess({this.data});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AppSuccess;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

AppError getLoggedError(String analyticsKey,
    {String title = "", String description = ""}) {
  AppError appError = AppError(title: title, description: description);
  return appError;
}
