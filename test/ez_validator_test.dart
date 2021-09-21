import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ez_validator/ez_validator.dart';

void main() {
  const MethodChannel channel = MethodChannel('ez_validator');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await EzValidator.platformVersion, '42');
  });
}
