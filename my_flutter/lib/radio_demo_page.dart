// radio_demo_page.dart
import 'package:flutter/material.dart';

class RadioDemoPage extends StatefulWidget {
  const RadioDemoPage({Key? key}) : super(key: key);

  @override
  State<RadioDemoPage> createState() => _RadioDemoPageState();
}

class _RadioDemoPageState extends State<RadioDemoPage> {
  String _selectedFruit = '苹果';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio 单选框演示'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Radio（单选框）用于在多个选项中选择一个。\n常用于表单、设置等场景。',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              '请选择你喜欢的水果：',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('苹果'),
              value: '苹果',
              groupValue: _selectedFruit,
              onChanged: (value) {
                setState(() {
                  _selectedFruit = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('香蕉'),
              value: '香蕉',
              groupValue: _selectedFruit,
              onChanged: (value) {
                setState(() {
                  _selectedFruit = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('橙子'),
              value: '橙子',
              groupValue: _selectedFruit,
              onChanged: (value) {
                setState(() {
                  _selectedFruit = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            Text(
              '你选择的是：$_selectedFruit',
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 32),
            const Text(
              '代码说明：\n'
              '- RadioListTile 用于构建带标签的单选项。\n'
              '- groupValue 表示当前选中的值。\n'
              '- value 表示该单选项的值。\n'
              '- onChanged 回调用于更新选中状态。',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
} 