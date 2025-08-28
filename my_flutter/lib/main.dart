// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'wrap_demo_page.dart';
import 'chip_demo_page.dart';
import 'image_icon_demo_page.dart';
import 'editable_table_demo_page.dart';
import 'stream_demo_page.dart';
import 'radio_demo_page.dart';
import 'animation_intro_page.dart';
import 'ios_flutter_communication_page.dart';
import 'bloc_intro_page.dart';
import 'login_page.dart';
import 'cubit_demo_page.dart';
import 'data_table_demo_page.dart';
import 'tab_bar_demo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI 组件演示',
      showPerformanceOverlay: false, // 关闭性能覆盖层
      debugShowCheckedModeBanner: false, // 隐藏调试标记
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Mac 平台特定优化
        visualDensity: Platform.isMacOS ? VisualDensity.adaptivePlatformDensity : VisualDensity.standard,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
          ),
        ),
        // Mac 平台字体优化
        fontFamily: Platform.isMacOS ? '.SF Pro Display' : null,
      ),
      home: const HomePage(),
      routes: {
        '/wrap_demo': (context) => const WrapDemoPage(),
        '/chip_demo': (context) => const ChipDemoPage(),
        '/image_icon_demo': (context) => const ImageIconDemoPage(),
        '/editable_table_demo': (context) => const EditableTableDemoPage(),
        '/stream_demo': (context) => const StreamDemoPage(),
        '/radio_demo': (context) => const RadioDemoPage(),
        '/animation_intro': (context) => const AnimationIntroPage(),
        '/ios_flutter_communication': (context) => const IosFlutterCommunicationPage(),
        '/bloc_intro': (context) => const BlocIntroPage(),
        '/login': (context) => const LoginPage(),
        '/cubit_demo': (context) => const CubitDemoPage(),
        '/data_table_demo': (context) => const DataTableDemoPage(),
        '/tab_bar_demo': (context) => const TabBarDemoPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _layoutType = 1; // 默认使用宽高比自适应布局

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 定义功能卡片数据
    final List<DemoCard> demoCards = [
      DemoCard(
        title: 'Wrap 布局演示',
        description: '展示 Flutter Wrap 组件的自动换行布局功能',
        icon: Icons.view_week,
        color: Colors.green,
        route: '/wrap_demo',
        features: ['自动换行', '间距控制', '响应式布局'],
      ),
      DemoCard(
        title: 'Chip 组件演示',
        description: '展示 Chip 组件的各种样式和交互效果',
        icon: Icons.label,
        color: Colors.orange,
        route: '/chip_demo',
        features: ['多种样式', '交互效果', '标签管理'],
      ),
      DemoCard(
        title: 'Image vs Icon 详解',
        description: '深入对比 Image 和 Icon 组件的使用场景',
        icon: Icons.image,
        color: Colors.blue,
        route: '/image_icon_demo',
        features: ['本地图片', '网络图片', '加载状态', '错误处理'],
      ),
      DemoCard(
        title: '可编辑表格演示',
        description: 'Excel 风格的表格编辑功能',
        icon: Icons.table_chart,
        color: Colors.purple,
        route: '/editable_table_demo',
        features: ['双击编辑', '增删行列', 'CSV 导出', '剪贴板复制'],
      ),
      DemoCard(
        title: 'Stream 数据流演示',
        description: '演示 Dart/Flutter Stream 的基本用法',
        icon: Icons.waves,
        color: Colors.teal,
        route: '/stream_demo',
        features: ['异步流', '多次事件', '监听'],
      ),
      DemoCard(
        title: 'Radio 单选框演示',
        description: '演示 Radio 单选框的基本用法',
        icon: Icons.radio_button_checked,
        color: Colors.redAccent,
        route: '/radio_demo',
        features: ['单选', '表单', '交互'],
      ),
      DemoCard(
        title: '动画 Animation',
        description: 'TweenAnimationBuilder、AnimatedWidget 等动画相关 Widget 详解',
        icon: Icons.animation,
        color: Colors.purpleAccent,
        route: '/animation_intro',
        features: ['TweenAnimationBuilder', 'AnimatedWidget', '动画效果'],
      ),
      DemoCard(
        title: '平台通道通信',
        description: 'Flutter 与 iOS/Android 原生通信（MethodChannel/EventChannel）演示',
        icon: Icons.usb,
        color: Colors.teal,
        route: '/ios_flutter_communication',
        features: ['MethodChannel', 'EventChannel', '原生通信'],
      ),
      DemoCard(
        title: 'Bloc 状态管理',
        description: 'Flutter Bloc 框架简介与真实计数器例子',
        icon: Icons.device_hub,
        color: Colors.indigo,
        route: '/bloc_intro',
        features: ['状态管理', '业务分离', '响应式'],
      ),
      DemoCard(
        title: '登录页 Bloc',
        description: 'Bloc 登录状态管理与校验演示',
        icon: Icons.login,
        color: Colors.blueGrey,
        route: '/login',
        features: ['登录', 'Bloc', '表单校验'],
      ),
      DemoCard(
        title: 'Cubit vs Bloc',
        description: 'Cubit 与 Bloc 状态管理对比演示',
        icon: Icons.compare_arrows,
        color: Colors.indigo,
        route: '/cubit_demo',
        features: ['Cubit', 'Bloc', '状态管理', '对比'],
      ),
      DemoCard(
        title: 'DataTable 表格演示',
        description: 'DataTable 组件的排序、选择、分页等功能详解',
        icon: Icons.table_rows,
        color: Colors.deepPurple,
        route: '/data_table_demo',
        features: ['表格展示', '排序功能', '行选择', '分页显示'],
      ),
      DemoCard(
        title: 'TabBar 标签页演示',
        description: 'TabBar 和 TabBarView 的基本用法演示',
        icon: Icons.tab,
        color: Colors.cyan,
        route: '/tab_bar_demo',
        features: ['标签页', '页面切换', '消息', '联系人', '设置'],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI 组件演示'),
        backgroundColor: theme.primaryColor,
        elevation: 2,
        centerTitle: true,
        actions: [
          // 显示当前布局模式
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _getLayoutTypeName(_layoutType),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // 添加布局切换按钮
          PopupMenuButton<int>(
            icon: const Icon(Icons.grid_view),
            tooltip: '切换布局模式',
            onSelected: (value) {
              // 更新布局类型并重新构建
              setState(() {
                _layoutType = value;
              });
              debugPrint('切换到布局模式: $value');
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.height),
                    SizedBox(width: 8),
                    Text('固定高度'),
                  ],
                ),
              ),
            const PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.aspect_ratio),
                  SizedBox(width: 8),
                  Text('宽高比自适应'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 2,
              child: Row(
                children: [
                  Icon(Icons.calculate),
                  SizedBox(width: 8),
                  Text('动态计算自适应'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 3,
              child: Row(
                children: [
                  Icon(Icons.view_week),
                  SizedBox(width: 8),
                  Text('最大宽度自适应'),
                ],
              ),
            ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[50]!,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题区域
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.flutter_dash,
                      size: 48,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Flutter UI 组件演示',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '探索 Flutter 强大的 UI 组件系统',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // 功能卡片网格
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // 根据屏幕宽度和设备类型确定网格配置
                    final gridConfig = _getGridConfig(constraints.maxWidth);
                    
                    // 选择使用哪种网格布局方式
                    switch (_layoutType) {
                      case 0:
                        // 使用固定高度布局   
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridConfig.crossAxisCount,
                            crossAxisSpacing: gridConfig.spacing,
                            mainAxisSpacing: gridConfig.spacing,
                            mainAxisExtent: gridConfig.cardHeight, // 使用固定高度
                          ),
                          itemCount: demoCards.length,
                          itemBuilder: (context, index) {
                            return _buildDemoCard(context, demoCards[index], gridConfig);
                          },
                        );
                      case 1:
                        // 使用宽高比自适应布局
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridConfig.crossAxisCount,
                            crossAxisSpacing: gridConfig.spacing,
                            mainAxisSpacing: gridConfig.spacing,
                            childAspectRatio: gridConfig.childAspectRatio, // 使用宽高比实现自适应
                          ),
                          itemCount: demoCards.length,
                          itemBuilder: (context, index) {
                            return _buildDemoCard(context, demoCards[index], gridConfig);
                          },
                        );
                      case 2:
                        // 使用动态计算自适应布局
                        return _buildDynamicAdaptiveGridView(demoCards, constraints.maxWidth);
                      default:
                        // 使用 SliverGridDelegateWithMaxCrossAxisExtent 自适应布局
                        return _buildAdaptiveGridView(demoCards, constraints.maxWidth);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoCard(BuildContext context, DemoCard card, GridConfig config) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, card.route),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
                          colors: [
              card.color.withValues(alpha: 0.1),
              card.color.withValues(alpha: 0.05),
            ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 图标和标题
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: card.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      card.icon,
                      color: card.color,
                      size: config.iconSize,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      card.title,
                      style: TextStyle(
                        fontSize: config.titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // 描述
              Text(
                card.description,
                style: TextStyle(
                  fontSize: config.descriptionFontSize,
                  color: Colors.grey[600],
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 12),
              
              // 功能标签
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: card.features.take(3).map((feature) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: card.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: config.tagFontSize,
                        color: card.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
  
              const Spacer(),
              // 底部提示 - 固定在底部
              Container(
                margin: const EdgeInsets.only(bottom: 0),
                color: Colors.red ,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: card.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '点击查看',
                      style: TextStyle(
                        fontSize: 10,
                        color: card.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
    
            ],
          ),
        ),
      ),
    );
  }

  // 根据屏幕宽度获取网格配置
  GridConfig _getGridConfig(double screenWidth) {
    if (screenWidth >= 1200) {
      // Mac 桌面端 - 4列布局
      return GridConfig(
        crossAxisCount: 4,
        spacing: 20,
        iconSize: 28,
        titleFontSize: 18,
        descriptionFontSize: 14,
        tagFontSize: 12,
        cardHeight: 180, // Mac 桌面端卡片高度
        childAspectRatio: 1.2, // 添加宽高比
      );
    } else if (screenWidth >= 768) {
      // iPad 平板端 - 3列布局
      return GridConfig(
        crossAxisCount: 3,
        spacing: 18,
        iconSize: 26,
        titleFontSize: 17,
        descriptionFontSize: 13,
        tagFontSize: 11,
        cardHeight: 200, // iPad 平板端卡片高度
        childAspectRatio: 1.1, // 添加宽高比
      );
    } else if (screenWidth >= 480) {
      // iPhone 横屏或大屏手机 - 2列布局
      return GridConfig(
        crossAxisCount: 2,
        spacing: 16,
        iconSize: 24,
        titleFontSize: 16,
        descriptionFontSize: 12,
        tagFontSize: 10,
        cardHeight: 220, // iPhone 横屏卡片高度
        childAspectRatio: 1.0, // 添加宽高比
      );
    } else {
      // iPhone 竖屏小屏手机 - 1列布局
      return GridConfig(
        crossAxisCount: 1,
        spacing: 12,
        iconSize: 32,
        titleFontSize: 20,
        descriptionFontSize: 16,
        tagFontSize: 12,
        cardHeight: 240, // iPhone 竖屏卡片高度
        childAspectRatio: 1.5, // 添加宽高比
      );
    }
  }

  // 使用 SliverGridDelegateWithMaxCrossAxisExtent 实现自适应行高
  Widget _buildAdaptiveGridView(List<DemoCard> demoCards, double screenWidth) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: _getMaxCrossAxisExtent(screenWidth),
        childAspectRatio: _getAdaptiveAspectRatio(screenWidth),
        crossAxisSpacing: _getSpacing(screenWidth),
        mainAxisSpacing: _getSpacing(screenWidth),
      ),
      itemCount: demoCards.length,
      itemBuilder: (context, index) {
        return _buildDemoCard(context, demoCards[index], _getGridConfig(screenWidth));
      },
    );
  }

  // 使用动态计算实现自适应行高
  Widget _buildDynamicAdaptiveGridView(List<DemoCard> demoCards, double screenWidth) {
    final gridConfig = _getGridConfig(screenWidth);
    
    // 动态计算卡片高度
    final availableWidth = screenWidth - (gridConfig.crossAxisCount - 1) * gridConfig.spacing - 32; // 减去边距
    final cardWidth = availableWidth / gridConfig.crossAxisCount;
    final dynamicHeight = _calculateDynamicHeight(cardWidth, gridConfig);
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridConfig.crossAxisCount,
        crossAxisSpacing: gridConfig.spacing,
        mainAxisSpacing: gridConfig.spacing,
        mainAxisExtent: dynamicHeight, // 使用动态计算的高度
      ),
      itemCount: demoCards.length,
      itemBuilder: (context, index) {
        return _buildDemoCard(context, demoCards[index], gridConfig);
      },
    );
  }

  // 根据卡片宽度动态计算高度
  double _calculateDynamicHeight(double cardWidth, GridConfig config) {
    // 基础高度计算
    double baseHeight = 0;
    
    // 图标和标题行高度
    baseHeight += 20 + config.iconSize + 12; // 图标容器 + 间距
    
    // 描述文字高度（根据字体大小和行数估算）
    baseHeight += config.descriptionFontSize * 1.3 * 2 + 12; // 2行描述 + 间距
    
    // 标签区域高度
    baseHeight += config.tagFontSize * 1.2 + 8 + 12; // 标签高度 + 间距
    
    // 底部提示高度
    baseHeight += 20 + 12; // 底部提示 + 间距
    
    // 卡片内边距
    baseHeight += 32; // 上下各16px
    
    // 根据卡片宽度调整高度（宽屏时适当增加高度）
    if (cardWidth > 300) {
      baseHeight *= 1.1; // 宽屏时增加10%高度
    } else if (cardWidth < 200) {
      baseHeight *= 0.9; // 窄屏时减少10%高度
    }
    
    return baseHeight;
  }

  // 根据屏幕宽度获取最大交叉轴尺寸
  double _getMaxCrossAxisExtent(double screenWidth) {
    if (screenWidth >= 1200) return 300; // Mac 桌面端
    if (screenWidth >= 768) return 250;  // iPad 平板端
    if (screenWidth >= 480) return 200;  // iPhone 横屏
    return screenWidth * 0.9; // iPhone 竖屏，使用90%屏幕宽度
  }

  // 根据屏幕宽度获取自适应宽高比
  double _getAdaptiveAspectRatio(double screenWidth) {
    if (screenWidth >= 1200) return 1.2; // Mac 桌面端
    if (screenWidth >= 768) return 1.1;  // iPad 平板端
    if (screenWidth >= 480) return 1.0;  // iPhone 横屏
    return 1.5; // iPhone 竖屏
  }

  // 根据屏幕宽度获取间距
  double _getSpacing(double screenWidth) {
    if (screenWidth >= 1200) return 20;
    if (screenWidth >= 768) return 18;
    if (screenWidth >= 480) return 16;
    return 12;
  }

  // 获取布局类型名称
  String _getLayoutTypeName(int layoutType) {
    switch (layoutType) {
      case 0:
        return '固定高度';
      case 1:
        return '宽高比';
      case 2:
        return '动态计算';
      case 3:
        return '最大宽度';
      default:
        return '自适应';
    }
  }
}

// 网格配置类
class GridConfig {
  final int crossAxisCount;
  final double spacing;
  final double iconSize;
  final double titleFontSize;
  final double descriptionFontSize;
  final double tagFontSize;
  final double cardHeight; // 添加卡片高度配置
  final double childAspectRatio; // 添加宽高比配置

  GridConfig({
    required this.crossAxisCount,
    required this.spacing,
    required this.iconSize,
    required this.titleFontSize,
    required this.descriptionFontSize,
    required this.tagFontSize,
    required this.cardHeight,
    required this.childAspectRatio,
  });
}

// 功能卡片数据模型
class DemoCard {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String route;
  final List<String> features;

  DemoCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
    required this.features,
  });
}

