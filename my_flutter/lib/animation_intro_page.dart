// animation_intro_page.dart
import 'package:flutter/material.dart';

class AnimationIntroPage extends StatelessWidget {
  const AnimationIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter 动画简介')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Flutter 动画简介',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Flutter 提供了丰富的动画支持，常用的动画 Widget 包括 TweenAnimationBuilder、AnimatedWidget、AnimatedBuilder、AnimatedContainer 等。动画可以让界面更加生动，提高用户体验。',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          const Text(
            '1. TweenAnimationBuilder',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'TweenAnimationBuilder 是一个封装好的动画组件，适合实现简单的补间动画。只需提供起止值、动画时长和构建函数，无需手动管理 AnimationController。',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(8),
            child: const SelectableText(
              'TweenAnimationBuilder<double>(\n'
              '  tween: Tween(begin: 0.0, end: 1.0),\n'
              '  duration: Duration(seconds: 1),\n'
              '  builder: (context, value, child) {\n'
              '    return Opacity(\n'
              '      opacity: value,\n'
              '      child: child,\n'
              '    );\n'
              '  },\n'
              '  child: Text(\'淡入文字\'),\n'
              ')',
              style: TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '2. AnimatedWidget',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'AnimatedWidget 是一个抽象类，简化了动画与 UI 的绑定。通过继承 AnimatedWidget，可以直接在 build 方法中使用动画的值。',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(8),
            child: const SelectableText(
              'class MyAnimatedLogo extends AnimatedWidget {\n'
              '  MyAnimatedLogo({Key? key, required Animation<double> animation})\n'
              '      : super(key: key, listenable: animation);\n'
              '\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    final animation = listenable as Animation<double>;\n'
              '    return Transform.scale(\n'
              '      scale: animation.value,\n'
              '      child: FlutterLogo(size: 100),\n'
              '    );\n'
              '  }\n'
              '}',
              style: TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '3. 其他常用动画 Widget',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '除了上述组件，Flutter 还提供了 AnimatedContainer、AnimatedOpacity、AnimatedPositioned 等封装好的动画组件，适合实现常见的属性动画。',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          const Text(
            '4. 总结',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Flutter 动画体系灵活强大，TweenAnimationBuilder 适合简单动画，AnimatedWidget/AnimatedBuilder 适合自定义复杂动画，封装类 AnimatedXXX 适合常见属性动画。',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          const Text(
            '5. 动画效果演示',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('下面是常用动画 Widget 的实际效果演示：', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          // TweenAnimationBuilder Demo
          _TweenAnimationDemo(),
          const SizedBox(height: 24),
          // AnimatedWidget Demo
          _AnimatedWidgetDemo(),
          const SizedBox(height: 24),
          // AnimatedContainer Demo
          _AnimatedContainerDemo(),
        ],
      ),
    );
  }
}

// TweenAnimationBuilder 动画演示
class _TweenAnimationDemo extends StatefulWidget {
  @override
  State<_TweenAnimationDemo> createState() => _TweenAnimationDemoState();
}

class _TweenAnimationDemoState extends State<_TweenAnimationDemo> {
  double _target = 0.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('TweenAnimationBuilder 示例（淡入淡出）', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: _target),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: const Text('Hello Animation!', style: TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _target = _target == 0.0 ? 1.0 : 0.0;
                });
              },
              child: Text(_target == 0.0 ? '淡入' : '淡出'),
            ),
          ],
        ),
      ),
    );
  }
}

// AnimatedWidget 动画演示
class _AnimatedWidgetDemo extends StatefulWidget {
  @override
  State<_AnimatedWidgetDemo> createState() => _AnimatedWidgetDemoState();
}

class _AnimatedWidgetDemoState extends State<_AnimatedWidgetDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('AnimatedWidget 示例（Logo 缩放）', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            MyAnimatedLogo(animation: _animation),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _controller.forward(),
                  child: const Text('放大'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => _controller.reverse(),
                  child: const Text('缩小'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyAnimatedLogo extends AnimatedWidget {
  const MyAnimatedLogo({Key? key, required Animation<double> animation}) : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.scale(
      scale: animation.value,
      child: const FlutterLogo(size: 60),
    );
  }
}

// AnimatedContainer 动画演示
class _AnimatedContainerDemo extends StatefulWidget {
  @override
  State<_AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<_AnimatedContainerDemo> {
  double _size = 80;
  Color _color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('AnimatedContainer 示例（大小和颜色变化）', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Center(
              child: AnimatedContainer(
                width: _size,
                height: _size,
                color: _color,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _size = _size == 80 ? 140 : 80;
                  _color = _color == Colors.blue ? Colors.orange : Colors.blue;
                });
              },
              child: const Text('切换动画'),
            ),
          ],
        ),
      ),
    );
  }
} 