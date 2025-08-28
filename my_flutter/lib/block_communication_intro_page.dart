// block_communication_intro_page.dart
import 'package:flutter/material.dart';

class BlockCommunicationIntroPage extends StatelessWidget {
  const BlockCommunicationIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iOS Block 通讯介绍'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '什么是 Block?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Block 是 iOS/Objective-C 中的一种匿名函数（闭包），可以捕获上下文变量，常用于回调、异步处理等场景。',
            ),
            const SizedBox(height: 24),
            Text(
              'Block 与 Flutter 通讯',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              '在 Flutter 与 iOS 原生交互时，常见的 Block 通讯场景有：\n'
              '1. Flutter 通过 MethodChannel 调用 iOS 原生方法，原生方法通过 Block 回调结果。\n'
              '2. iOS 原生插件内部使用 Block 处理异步事件，再通过 MethodChannel 回传给 Flutter。',
            ),
            const SizedBox(height: 24),
            Text(
              'iOS Block 示例',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.grey[200],
              child: const SelectableText(
                '// Objective-C Block 声明与调用\n'
                'typedef void(^MyBlock)(NSString *result);\n\n'
                '- (void)doSomethingWithBlock:(MyBlock)block {\n'
                '    // 异步操作\n'
                '    dispatch_async(dispatch_get_global_queue(0, 0), ^{\n'
                '        NSString *result = @"Block 回调结果";\n'
                '        dispatch_async(dispatch_get_main_queue(), ^{\n'
                '            block(result);\n'
                '        });\n'
                '    });\n'
                '}\n',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Flutter 与 iOS Block 通讯流程',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              '1. Flutter 通过 MethodChannel 调用原生方法。\n'
              '2. iOS 原生方法执行异步任务，完成后通过 Block 回调。\n'
              '3. Block 回调结果通过 MethodChannel 返回给 Flutter。',
            ),
            const SizedBox(height: 24),
            Text(
              '小结',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Block 是 iOS 原生开发中常用的回调机制，Flutter 与 iOS 通讯时常用 Block 处理异步回调。',
            ),
          ],
        ),
      ),
    );
  }
} 