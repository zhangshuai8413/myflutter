// chip_demo_page.dart
import 'package:flutter/material.dart';

class ChipDemoPage extends StatefulWidget {
  const ChipDemoPage({super.key});

  @override
  State<ChipDemoPage> createState() => _ChipDemoPageState();
}

class _ChipDemoPageState extends State<ChipDemoPage> {
  final List<String> _selectedChips = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chip 组件演示'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. 基础 Chip', theme),
            _buildBasicChips(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('2. 带图标的 Chip', theme),
            _buildIconChips(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('3. 可删除的 Chip', theme),
            _buildDeletableChips(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('4. 可选择的 Chip', theme),
            _buildSelectableChips(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('5. 不同样式的 Chip', theme),
            _buildStyledChips(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('6. 带头像的 Chip', theme),
            _buildAvatarChips(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('7. 在 Wrap 中的 Chip', theme),
            _buildWrapChips(),
            
            const SizedBox(height: 30),
            _buildSectionTitle('8. 已选择的 Chip', theme),
            _buildSelectedChips(),
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
          color: Colors.orange[800],
        ),
      ),
    );
  }

  Widget _buildBasicChips() {
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
          const Chip(label: Text('基础 Chip')),
          Chip(
            label: const Text('带颜色的 Chip'),
            backgroundColor: Colors.blue[100],
          ),
          Chip(
            label: const Text('带边框的 Chip'),
            side: BorderSide(color: Colors.green[400]!),
          ),
          Chip(
            label: const Text('圆角 Chip'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconChips() {
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
          const Chip(
            label: Text('带图标'),
            avatar: Icon(Icons.star, size: 16),
          ),
          Chip(
            label: const Text('带颜色图标'),
            avatar: const Icon(Icons.favorite, size: 16, color: Colors.red),
            backgroundColor: Colors.red[50],
          ),
          const Chip(
            label: Text('带圆形头像'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('A', style: TextStyle(color: Colors.white)),
            ),
          ),
          const Chip(
            label: Text('带本地图标'),
            avatar: CircleAvatar(
              backgroundColor: Colors.purple,
              child: Icon(Icons.image, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeletableChips() {
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
          Chip(
            label: const Text('可删除'),
            onDeleted: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('删除功能演示')),
              );
            },
          ),
          Chip(
            label: const Text('自定义删除图标'),
            onDeleted: () {},
            deleteIcon: const Icon(Icons.close, size: 18),
          ),
          Chip(
            label: const Text('带颜色的可删除'),
            backgroundColor: Colors.green[100],
            onDeleted: () {},
            deleteIconColor: Colors.green[700],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableChips() {
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
          FilterChip(
            label: const Text('可选择的 Chip'),
            selected: false,
            onSelected: (bool selected) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('选择了: $selected')),
              );
            },
          ),
          FilterChip(
            label: const Text('已选择的 Chip'),
            selected: true,
            selectedColor: Colors.blue[200],
            onSelected: (bool selected) {},
          ),
          FilterChip(
            label: const Text('带图标的可选择'),
            selected: false,
            avatar: const Icon(Icons.check, size: 16),
            onSelected: (bool selected) {},
          ),
        ],
      ),
    );
  }

  Widget _buildStyledChips() {
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
          // 成功样式
          const Chip(
            label: Text('成功', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
            elevation: 2,
          ),
          // 警告样式
          const Chip(
            label: Text('警告', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.orange,
            elevation: 2,
          ),
          // 错误样式
          const Chip(
            label: Text('错误', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            elevation: 2,
          ),
          // 信息样式
          const Chip(
            label: Text('信息', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.blue,
            elevation: 2,
          ),
          // 渐变样式
          Chip(
            label: const Text('渐变', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.purple,
            elevation: 4,
            shadowColor: Colors.purple.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarChips() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          Chip(
            label: Text('用户头像'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('张', style: TextStyle(color: Colors.white)),
            ),
          ),
          Chip(
            label: Text('本地头像'),
            avatar: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('李', style: TextStyle(color: Colors.white)),
            ),
          ),
          Chip(
            label: Text('图标头像'),
            avatar: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white, size: 16),
            ),
          ),
          Chip(
            label: Text('字母头像'),
            avatar: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text('王', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWrapChips() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          Chip(label: Text('Flutter')),
          Chip(label: Text('Dart')),
          Chip(label: Text('Widget')),
          Chip(label: Text('Material Design')),
          Chip(label: Text('Cupertino')),
          Chip(label: Text('StatefulWidget')),
          Chip(label: Text('StatelessWidget')),
          Chip(label: Text('BuildContext')),
          Chip(label: Text('setState')),
          Chip(label: Text('Hot Reload')),
        ],
      ),
    );
  }

  Widget _buildSelectedChips() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('已选择的标签 (${_selectedChips.length}):', 
               style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _selectedChips.map((chip) => Chip(
              label: Text(chip),
              onDeleted: () {
                setState(() {
                  _selectedChips.remove(chip);
                });
              },
            )).toList(),
          ),
          const SizedBox(height: 20),
          const Text('选择更多标签:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: ['标签1', '标签2', '标签3', '标签4', '标签5'].map((chip) {
              bool isSelected = _selectedChips.contains(chip);
              return FilterChip(
                label: Text(chip),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedChips.add(chip);
                    } else {
                      _selectedChips.remove(chip);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
} 