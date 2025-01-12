import 'package:flutter/material.dart'; // Import Flutter Material package
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'lib/main.dart'; // Correct the import path

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp()); // Use runApp to start the application
}
