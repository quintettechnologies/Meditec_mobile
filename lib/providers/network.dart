import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final networkProvider = Provider<HttpClient>((ref) {
  return HttpClient();
});
