// stream_demo_page.dart
import 'package:flutter/material.dart';
import 'dart:async';

class StreamDemoPage extends StatefulWidget {
  const StreamDemoPage({Key? key}) : super(key: key);

  @override
  State<StreamDemoPage> createState() => _StreamDemoPageState();
}

class _StreamDemoPageState extends State<StreamDemoPage> {
  late StreamController<int> _controller;
  late Stream<int> _stream;
  int _counter = 0;
  final List<int> _received = [];
  StreamSubscription<int>? _subscription;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>();
    _stream = _controller.stream;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller.close();
    super.dispose();
  }

  void _startStream() {
    if (_isListening) return;
    _received.clear();
    _subscription = _stream.listen((data) {
      setState(() {
        _received.add(data);
      });
    });
    setState(() {
      _isListening = true;
    });
  }

  void _addData() {
    if (_isListening) {
      _counter++;
      _controller.add(_counter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream（数据流）演示'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stream 是 Dart/Flutter 处理异步多次事件的工具，适合处理数据流、实时推送等场景。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '下面是一个简单的 Stream 演示：',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _isListening ? null : _startStream,
                  child: const Text('开始监听'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _isListening ? _addData : null,
                  child: const Text('添加数据'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('收到的数据: ${_received.join(", ")}'),
            const SizedBox(height: 32),
            const Text(
              '知识点说明：\n'
              '- Stream 可以持续不断地发出数据，适合处理异步数据流。\n'
              '- 通过 listen 订阅数据流，收到每一个事件。\n'
              '- 常用于网络推送、WebSocket、用户输入等场景。',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
} 