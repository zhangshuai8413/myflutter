// ios_flutter_communication_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IosFlutterCommunicationPage extends StatefulWidget {
  const IosFlutterCommunicationPage({Key? key}) : super(key: key);

  @override
  State<IosFlutterCommunicationPage> createState() => _IosFlutterCommunicationPageState();
}

class _IosFlutterCommunicationPageState extends State<IosFlutterCommunicationPage> {
  String _batteryLevel = '未获取';
  static const MethodChannel _channel = MethodChannel('samples.flutter.dev/battery');

  Future<void> _getBatteryLevel() async {
    String resultText;
    try {
      final int result = await _channel.invokeMethod('getBatteryLevel');
      resultText = '当前电量: $result%';
    } on PlatformException catch (e) {
      resultText = '获取失败: ${e.message}';
    }
    setState(() {
      _batteryLevel = resultText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('iOS/Android 与 Flutter 通信详解')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'iOS/Android 与 Flutter 通信',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _getBatteryLevel,
            child: const Text('获取设备电池电量（iOS/Android）'),
          ),
          const SizedBox(height: 12),
          Text(_batteryLevel, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 24),
          const Divider(),
          const Text(
            'Flutter 通过平台通道（Platform Channel）与原生 iOS/Android 代码进行通信，常用的有 MethodChannel（方法调用）和 EventChannel（事件流）。',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          const Text(
            'MethodChannel 支持 iOS 和 Android，原生端需分别实现 getBatteryLevel 方法。',
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
          const SizedBox(height: 24),
          const Text(
            '1. MethodChannel：方法调用',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'MethodChannel 适合一次性方法调用和数据请求，支持 Flutter 调用 iOS，也支持 iOS 调用 Flutter。',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text('Flutter 端示例：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(8),
            child: const SelectableText(
              "static const platform = MethodChannel('samples.flutter.dev/battery');\n\nFuture<void> getBatteryLevel() async {\n  try {\n    final int result = await platform.invokeMethod('getBatteryLevel');\n    print('Battery level: \$result');\n  } on PlatformException catch (e) {\n    print('Failed to get battery level: \${e.message}');\n  }\n}",
              style: TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
          ),
          const SizedBox(height: 8),
          const Text('iOS 端 Swift 示例：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(8),
            child: const SelectableText(
              "let controller = window?.rootViewController as! FlutterViewController\nlet batteryChannel = FlutterMethodChannel(name: \"samples.flutter.dev/battery\", binaryMessenger: controller.binaryMessenger)\nbatteryChannel.setMethodCallHandler { (call, result) in\n  if call.method == \"getBatteryLevel\" {\n    // 获取电池电量并返回\n    result(batteryLevel)\n  }\n}",
              style: TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '2. EventChannel：事件流',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'EventChannel 适合原生端持续向 Flutter 推送事件（如传感器、系统广播等）。',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text('Flutter 端示例：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(8),
            child: const SelectableText(
              "static const eventChannel = EventChannel('samples.flutter.dev/charging');\n\neventChannel.receiveBroadcastStream().listen((event) {\n  print('Charging status: \$event');\n});",
              style: TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
          ),
          const SizedBox(height: 8),
          const Text('iOS 端 Swift 示例：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(8),
            child: const SelectableText(
              "let chargingChannel = FlutterEventChannel(name: \"samples.flutter.dev/charging\", binaryMessenger: controller.binaryMessenger)\nchargingChannel.setStreamHandler(self)\n\nextension AppDelegate: FlutterStreamHandler {\n  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {\n    // 持续推送数据\n    events(\"charging\")\n    return nil\n  }\n  func onCancel(withArguments arguments: Any?) -> FlutterError? {\n    return nil\n  }\n}",
              style: TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '3. 总结',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'MethodChannel 适合方法调用和数据请求，EventChannel 适合事件流推送。两者结合可实现 Flutter 与 iOS 的高效通信。',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
} 