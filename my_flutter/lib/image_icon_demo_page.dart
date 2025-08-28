// image_icon_demo_page.dart
import 'package:flutter/material.dart';

class ImageIconDemoPage extends StatefulWidget {
  const ImageIconDemoPage({super.key});

  @override
  State<ImageIconDemoPage> createState() => _ImageIconDemoPageState();
}

class _ImageIconDemoPageState extends State<ImageIconDemoPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image vs Icon 详解'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewSection(theme),
            
            const SizedBox(height: 30),
            _buildIconSection(theme),
            
            const SizedBox(height: 30),
            _buildImageSection(theme),
            
            const SizedBox(height: 30),
            _buildComparisonSection(theme),
            
            const SizedBox(height: 30),
            _buildUsageExamples(theme),
            
            const SizedBox(height: 30),
            _buildBestPractices(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📋 Image vs Icon 概述',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 16),
          _buildComparisonTable(),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Table(
        border: TableBorder.all(color: const Color.fromARGB(255, 38, 16, 146)),
        children: [
          TableRow(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 9, 148, 67)),
            children: [
              _buildTableCell('特性', isHeader: false),
              _buildTableCell('Icon', isHeader: true),
              _buildTableCell('Image', isHeader: true),
            ],
          ),
          TableRow(
            children: [
              _buildTableCell('类型'),
              _buildTableCell('矢量图标'),
              _buildTableCell('位图/矢量图'),
            ],
          ),
          TableRow(
            children: [
              _buildTableCell('缩放'),
              _buildTableCell('无损缩放'),
              _buildTableCell('可能失真'),
            ],
          ),
          TableRow(
            children: [
              _buildTableCell('文件大小'),
              _buildTableCell('很小'),
              _buildTableCell('较大'),
            ],
          ),
          TableRow(
            children: [
              _buildTableCell('颜色'),
              _buildTableCell('可动态改变'),
              _buildTableCell('固定颜色'),
            ],
          ),
          TableRow(
            children: [
              _buildTableCell('加载'),
              _buildTableCell('即时加载'),
              _buildTableCell('异步加载'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.blue[800] : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildIconSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎨 Icon 详解',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange[800],
            ),
          ),
          const SizedBox(height: 16),
          
          // 基础 Icon
          _buildSubSection('1. 基础 Icon', [
            const Icon(Icons.star, size: 24),
            const Icon(Icons.favorite, size: 32, color: Colors.red),
            const Icon(Icons.home, size: 40, color: Colors.blue),
            const Icon(Icons.settings, size: 48, color: Colors.grey),
          ]),
          
          const SizedBox(height: 16),
          
          // 不同样式的 Icon
          _buildSubSection('2. 不同样式的 Icon', [
            Icon(Icons.star, size: 24, color: Colors.amber[400]),
            Icon(Icons.star_border, size: 24, color: Colors.amber[400]),
            Icon(Icons.star_half, size: 24, color: Colors.amber[400]),
            Icon(Icons.star_outline, size: 24, color: Colors.amber[400]),
          ]),
          
          const SizedBox(height: 16),
          
          // Icon 在按钮中的使用
          _buildSubSection('3. Icon 在按钮中的使用', [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
              color: Colors.red,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('添加'),
            ),
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ]),
          
          const SizedBox(height: 16),
          
          // Icon 属性说明
          _buildCodeExample('''
// Icon 主要属性
Icon(
  Icons.star,           // 图标类型
  size: 24,             // 大小
  color: Colors.red,    // 颜色
  semanticLabel: '星标', // 语义标签（无障碍）
)
          '''),
        ],
      ),
    );
  }

  Widget _buildImageSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🖼️ Image 详解',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 16),
          
          // 本地图片
          _buildSubSection('1. 本地图片', [
            Image.asset(
              'assets/images/flutter_logo.png',
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
            Image.asset(
              'assets/images/dart_logo.png',
              width: 60,
              height: 60,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ]),
          
          const SizedBox(height: 16),
          
          // 网络图片
          _buildSubSection('2. 网络图片', [
            Image.network(
              'https://picsum.photos/50/50?random=1',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.cloud_download, color: Colors.blue),
                );
              },
            ),
            Image.network(
              'https://picsum.photos/60/60?random=2',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.image, color: Colors.green),
                );
              },
            ),
          ]),
          
          const SizedBox(height: 16),
          
          // 图片属性
          _buildSubSection('3. 图片属性示例', [
            Image.network(
              'https://picsum.photos/80/60?random=3',
              width: 80,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.fit_screen, color: Colors.purple),
                );
              },
            ),
            Image.network(
              'https://picsum.photos/60/80?random=4',
              width: 60,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.aspect_ratio, color: Colors.orange),
                );
              },
            ),
          ]),
          
          const SizedBox(height: 16),
          
          // 网络图片加载状态
          _buildSubSection('4. 网络图片加载状态', [
            Image.network(
              'https://picsum.photos/100/100?random=5',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.error, color: Colors.red),
                );
              },
            ),
            Image.network(
              'https://picsum.photos/120/80?random=6',
              width: 120,
              height: 80,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.error, color: Colors.red),
                );
              },
            ),
          ]),
          
          const SizedBox(height: 16),
          
          // Image 代码示例
          _buildCodeExample('''
// 本地图片
Image.asset(
  'assets/images/logo.png',  // 图片路径
  width: 100,                // 宽度
  height: 100,               // 高度
  fit: BoxFit.cover,         // 适配方式
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error); // 错误处理
  },
)

// 网络图片
Image.network(
  'https://example.com/image.jpg',  // 网络图片URL
  width: 100,                       // 宽度
  height: 100,                      // 高度
  fit: BoxFit.cover,                // 适配方式
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return CircularProgressIndicator(); // 加载指示器
  },
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error); // 错误处理
  },
)
          '''),
        ],
      ),
    );
  }

  Widget _buildComparisonSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⚖️ 详细对比',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple[800],
            ),
          ),
          const SizedBox(height: 16),
          
          _buildComparisonItem(
            '🎯 使用场景',
            'Icon: 界面元素、按钮、导航、状态指示',
            'Image: 用户头像、产品图片、背景图、内容展示',
            Colors.purple[100]!,
          ),
          
          const SizedBox(height: 12),
          
          _buildComparisonItem(
            '📏 尺寸控制',
            'Icon: 通过 size 属性精确控制',
            'Image: 通过 width/height 或 fit 属性控制',
            Colors.purple[100]!,
          ),
          
          const SizedBox(height: 12),
          
          _buildComparisonItem(
            '🎨 颜色处理',
            'Icon: 直接通过 color 属性改变颜色',
            'Image: 通过 color 和 colorBlendMode 添加滤镜',
            Colors.purple[100]!,
          ),
          
          const SizedBox(height: 12),
          
          _buildComparisonItem(
            '⚡ 性能表现',
            'Icon: 渲染速度快，内存占用小',
            'Image: 需要解码，大图片可能影响性能',
            Colors.purple[100]!,
          ),
          
          const SizedBox(height: 12),
          
          _buildComparisonItem(
            '🔄 加载方式',
            'Icon: 同步加载，立即可用',
            'Image: 异步加载，需要处理加载状态',
            Colors.purple[100]!,
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonItem(String title, String iconDesc, String imageDesc, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              const Icon(Icons.star, size: 16, color: Colors.orange),
              const SizedBox(width: 8),
              Expanded(child: Text(iconDesc, style: const TextStyle(fontSize: 12))),
            ],
          ),
          const SizedBox(height: 4),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              const Icon(Icons.image, size: 16, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(child: Text(imageDesc, style: const TextStyle(fontSize: 12))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUsageExamples(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💡 使用示例',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.indigo[800],
            ),
          ),
          const SizedBox(height: 16),
          
          // 列表项示例
          _buildSubSection('1. 列表项中的使用', [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: const Text('用户头像'),
              subtitle: const Text('使用 Icon 作为占位符'),
              trailing: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
            ),
            ListTile(
              leading: ClipOval(
                child: Image.network(
                  'https://picsum.photos/40/40?random=7',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.person, color: Colors.blue),
                    );
                  },
                ),
              ),
              title: const Text('用户信息'),
              subtitle: const Text('使用网络图片显示真实头像'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ]),
          
          const SizedBox(height: 16),
          
          // 卡片示例
          _buildSubSection('2. 卡片中的使用', [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 32),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('收藏功能', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('使用 Icon 表示功能状态'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://picsum.photos/60/60?random=8',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.photo, color: Colors.green, size: 32),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('产品展示', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('使用网络图片展示产品'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildBestPractices(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '✅ 最佳实践',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal[800],
            ),
          ),
          const SizedBox(height: 16),
          
          _buildPracticeItem(
            '🎯 选择合适的组件',
            '• 界面元素、按钮、导航 → 使用 Icon\n• 用户内容、产品图片 → 使用 Image',
            Icons.check_circle,
            Colors.green,
          ),
          
          const SizedBox(height: 12),
          
          _buildPracticeItem(
            '⚡ 性能优化',
            '• Icon: 优先使用系统图标\n• Image: 压缩图片、使用缓存、懒加载',
            Icons.speed,
            Colors.blue,
          ),
          
          const SizedBox(height: 12),
          
          _buildPracticeItem(
            '🎨 用户体验',
            '• 提供加载状态和错误处理\n• 保持视觉一致性',
            Icons.face,
            Colors.orange,
          ),
          
          const SizedBox(height: 12),
          
          _buildPracticeItem(
            '📱 响应式设计',
            '• 使用相对尺寸\n• 适配不同屏幕密度',
            Icons.phone_android,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeItem(String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: children,
        ),
      ],
    );
  }

  Widget _buildCodeExample(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    );
  }
} 