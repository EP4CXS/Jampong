import 'main_prod.dart' as prod;

/// Default entrypoint forwarding to `main_prod.dart`.
/// Keeps `flutter build` working without specifying `-t`.
void main() => prod.main();
