import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ez_validator/ez_validator_method_channel.dart';

void main() {
  MethodChannelEzValidator platform = MethodChannelEzValidator();
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
    expect(await platform.getPlatformVersion(), '42');
  });
}
