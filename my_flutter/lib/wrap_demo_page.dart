// wrap_demo_page.dart
import 'package:flutter/material.dart';

class WrapDemoPage extends StatelessWidget {
  const WrapDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wrap 布局演示'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. 基础 Wrap 布局', theme),
            _buildBasicWrap(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('2. 设置间距的 Wrap', theme),
            _buildSpacingWrap(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('3. 不同对齐方式的 Wrap', theme),
            _buildAlignmentWrap(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('4. 标签样式的 Wrap', theme),
            _buildTagWrap(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('5. 响应式 Wrap', theme),
            _buildResponsiveWrap(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  Widget _buildBasicWrap() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        children: [
          _buildChip('Flutter', Colors.blue),
          _buildChip('Dart', Colors.green),
          _buildChip('Widget', Colors.orange),
          _buildChip('Layout', Colors.purple),
          _buildChip('Material Design 但看见年假单', Colors.red),
          _buildChip('Cupertino', Colors.indigo),
          _buildChip('Cupertino', Colors.indigo),
          _buildChip('Cupertino', Colors.indigo),
        ],
      ),
    );
  }

  Widget _buildSpacingWrap() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 8.0, // 水平间距
        runSpacing: 8.0, // 垂直间距
        children: [
          _buildChip('Android', Colors.green),
          _buildChip('iOS', Colors.blue),
          _buildChip('Web', Colors.orange),
          _buildChip('Desktop', Colors.purple),
          _buildChip('Mobile', Colors.red),
        ],
      ),
    );
  }

  Widget _buildAlignmentWrap() {
    return Column(
      children: [
        Text('start 对齐:', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 8.0,
            children: [
              _buildChip('Start', Colors.blue),
              _buildChip('Alignment', Colors.green),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text('center 对齐:', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            children: [
              _buildChip('Center', Colors.blue),
              _buildChip('Alignment', Colors.green),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text('end 对齐:', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Wrap(
            alignment: WrapAlignment.end,
            spacing: 8.0,
            children: [
              _buildChip('End', Colors.blue),
              _buildChip('Alignment', Colors.green),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagWrap() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          _buildTag('热门', Colors.red),
          _buildTag('推荐', Colors.orange),
          _buildTag('最新', Colors.green),
          _buildTag('精选', Colors.blue),
          _buildTag('特价', Colors.purple),
          _buildTag('限时', Colors.pink),
        ],
      ),
    );
  }

  Widget _buildResponsiveWrap() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 20.0,
        children: [
          _buildResponsiveChip('小屏幕适配', Colors.teal),
          _buildResponsiveChip('中等屏幕适配', Colors.indigo),
          _buildResponsiveChip('大屏幕适配', Colors.deepPurple),
          _buildResponsiveChip('平板适配', Colors.cyan),
          _buildResponsiveChip('手机适配', Colors.lime),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildResponsiveChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
} 