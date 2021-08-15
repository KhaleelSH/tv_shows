# TV Shows

A simple app that helps you keep track of shows and episodes you watched.

---

## Libraries Used

### Dependencies

- `flutter_secure_storage`: It provides an API to store data in secure storage. I use it to store JWT if the user chose
  to remember his login credentials.
- `image_picker`: It allows the user to select images from the image library or the camera. I use it in `AddEpisodePage`
  to select episode picture.
- `loggy`: I know you won’t be surprised, but I use it for logging ;).
- `flutter_loggy_dio`: I use the dio interceptor to print all http network requests, responses, or errors.
- `json_annotation`: supports JSON code generation. I use `json_annotation` and `json_serializable` to serialize model
  objects.
- `dio`: A powerful Http client. It supports Interceptors and FormData. I use `dio` to handle all network
  communications.
- `provider`: A wrapper around InheritedWidget to make them easier to use and more reusable. I use it to make state
  management much easier. More specifically, I make use of Proxy Providers which ease the cases when providers depend on
  each others.

### DevDependencies

- `flutter_lints`: A static analysis library which contains the recommended lints for Flutter.
- `json_serializable`: Json serialization code generator. It generates toJson and fromJson methods for model objects.
- `build_runner`: A build system for Dart code generation. I use it to run json serialization code generator.

---

## Notes

- Flutter version used is: `Flutter 2.2.3 • channel stable`
- The code is sound null-safe so there won't be null errors (hopefully :D).
- Some widgets are adaptive and appears different based on the operating system, ex:`RefreshIndicator`
  or `CircularProgressIndicator`
- All (maybe) edge cases are supported, ex:
    - Wrong login credentials error.
    - Loading data widgets.
    - No data (ex: shows, episodes, comments) to display.