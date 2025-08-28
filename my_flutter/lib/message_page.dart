// message_page.dart
import 'package:flutter/material.dart';

// 常量定义
class MessageConstants {
  // 颜色常量
  static const Color primaryColor = Colors.blue;
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black;
  static const Color subtitleColor = Colors.grey;
  static const Color borderColor = Color(0xFFE5E5E5);
  
  // 尺寸常量
  static const double avatarSize = 40.0;
  static const double smallAvatarSize = 12.0;
  static const double iconSize = 20.0;
  static const double smallIconSize = 8.0;
  static const double appBarIconSize = 24.0;
  
  // 字体大小常量
  static const double titleFontSize = 18.0;
  static const double subtitleFontSize = 16.0;
  static const double messageFontSize = 14.0;
  static const double dateFontSize = 12.0;
  static const double buttonFontSize = 16.0;
  
  // 间距常量
  static const double horizontalPadding = 16.0;
  static const double verticalPadding = 12.0;
  static const double avatarSpacing = 12.0;
  static const double contentSpacing = 8.0;
  static const double titleSpacing = 4.0;
  
  // 边框常量
  static const double borderWidth = 0.5;
  
  // 文本常量
  static const String editButtonText = 'Edit';
  static const String titleText = 'Message';
  static const String addButtonTooltip = 'Add new message';
  static const String addContactTitle = '添加新联系人';
  static const String contactNameLabel = '联系人名称';
  static const String initialMessageLabel = '初始消息';
  static const String typeLabel = '类型: ';
  static const String personalLabel = '个人';
  static const String groupLabel = '群组';
  static const String cancelText = '取消';
  static const String addText = '添加';
  static const String contactAddedText = '已添加联系人: ';
  static const String groupAddedText = '已添加群组: ';
  static const String pleaseEnterNameText = '请输入联系人名称';
  static const String doneText = 'Done';
  static const String deleteText = '删除';
  static const String confirmDeleteText = '确认删除';
  static const String deleteMessageText = '确定要删除这条消息吗？';
}

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  // 编辑模式状态
  bool _isEditMode = false;

  // 消息列表数据
  List<Map<String, dynamic>> _messages = [
    {
      'id': '1',
      'title': '自己发的消息跑到左边问题讨论',
      'message': 'Louis Go: 这个命名可能有歧义,但是实际...',
      'date': '29/05',
      'isGroup': true,
      'avatarColor': Colors.green,
    },
    {
      'id': '2',
      'title': 'jarvis:为什么看不到我的头像?...',
      'message': 'jarvis: 测试',
      'date': '28/05',
      'isGroup': false,
      'hasPlus': true,
    },
    {
      'id': '3',
      'title': '线上闪退/崩溃问题群',
      'message': 'Frannie:好的',
      'date': '27/05',
      'isGroup': true,
      'avatarColor': Colors.green,
    },
    {
      'id': '4',
      'title': '线上ios包丢消息问题',
      'message': 'Caesar: 大面积出现<at 里面没有跟username',
      'date': '27/05',
      'isGroup': true,
      'avatarColor': Colors.green,
    },
    {
      'id': '5',
      'title': '添加好友二维码优化',
      'message': 'Lou Xu: 没办法对应到具体的人',
      'date': '27/05',
      'isGroup': true,
      'avatarColor': Colors.blue,
    },
    {
      'id': '6',
      'title': '新增清除缓存功能',
      'message': 'Frannie invited butsalt 1',
      'date': '26/05',
      'isGroup': true,
      'avatarColor': Colors.green,
    },
    {
      'id': '7',
      'title': 'Vi da:这个接口前端有调用吗 把...',
      'message': 'milly: klay说也不行,改了简历名称也不可以',
      'date': '21/05',
      'isGroup': false,
      'hasPlus': true,
    },
    {
      'id': '8',
      'title': 'jarvis: @klay lauPyMuPDF 这...',
      'message': 'klay lau: ok。',
      'date': '20/05',
      'isGroup': false,
      'hasPlus': true,
    },
    {
      'id': '9',
      'title': 'mac问题反馈群',
      'message': 'Yara- QA 工作号: Cristiano Ronaldo 7 hav...',
      'date': '30/04',
      'isGroup': true,
      'avatarColor': Colors.blue,
    },
    {
      'id': '10',
      'title': '产品经理 - 张经理',
      'message': '张经理: 下周的需求评审会议记得参加',
      'date': '29/05',
      'isGroup': false,
    },
    {
      'id': '11',
      'title': 'Flutter 技术交流群',
      'message': '小明: 有人知道怎么处理状态管理吗？',
      'date': '28/05',
      'isGroup': true,
      'avatarColor': Colors.purple,
    },
    {
      'id': '12',
      'title': '设计师 - 李设计师',
      'message': '李设计师: 新的设计稿已经上传到 Figma',
      'date': '28/05',
      'isGroup': false,
      'hasPlus': true,
    },
    {
      'id': '13',
      'title': '项目进度同步群',
      'message': '项目经理: 本周的进度报告已更新',
      'date': '27/05',
      'isGroup': true,
      'avatarColor': Colors.orange,
    },
    {
      'id': '14',
      'title': '测试工程师 - 王测试',
      'message': '王测试: 发现了一个新的 bug，需要修复',
      'date': '26/05',
      'isGroup': false,
    },
    {
      'id': '15',
      'title': 'UI/UX 设计讨论',
      'message': '设计师: 用户反馈界面需要优化',
      'date': '25/05',
      'isGroup': true,
      'avatarColor': Colors.teal,
    },
    {
      'id': '16',
      'title': '后端开发 - 刘后端',
      'message': '刘后端: API 接口已经更新完成',
      'date': '24/05',
      'isGroup': false,
      'hasPlus': true,
    },
    {
      'id': '17',
      'title': '代码审查群',
      'message': '代码审查员: 请查看最新的代码提交',
      'date': '23/05',
      'isGroup': true,
      'avatarColor': Colors.indigo,
    },
    {
      'id': '18',
      'title': '运维工程师 - 陈运维',
      'message': '陈运维: 服务器维护将在今晚进行',
      'date': '22/05',
      'isGroup': false,
    },
    {
      'id': '19',
      'title': '紧急问题处理群',
      'message': '系统管理员: 系统出现异常，正在处理',
      'date': '21/05',
      'isGroup': true,
      'avatarColor': Colors.red,
    },
    {
      'id': '20',
      'title': '数据分析师 - 赵分析',
      'message': '赵分析: 用户行为分析报告已生成',
      'date': '20/05',
      'isGroup': false,
      'hasPlus': true,
    },
  ];

  // 切换编辑模式
  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  // 删除消息
  void _deleteMessage(String id) {
    setState(() {
      _messages.removeWhere((message) => message['id'] == id);
    });
  }

  // 显示删除确认对话框
  void _showDeleteConfirmDialog(String id, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(MessageConstants.confirmDeleteText),
          content: Text('${MessageConstants.deleteMessageText}\n"$title"'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(MessageConstants.cancelText),
            ),
            TextButton(
              onPressed: () {
                _deleteMessage(id);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('已删除: $title'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(MessageConstants.deleteText),
            ),
          ],
        );
      },
    );
  }

  // 添加新联系人到列表
  void _addNewContact(String name, String message, bool isGroup) {
    final now = DateTime.now();
    final newContact = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': name,
      'message': message.isNotEmpty ? message : '新对话',
      'date': '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}',
      'isGroup': isGroup,
      'avatarColor': isGroup ? Colors.green : null,
      'hasPlus': !isGroup, // 个人联系人默认有加号标记
    };

    setState(() {
      _messages.insert(0, newContact); // 插入到列表开头
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 自定义顶部栏
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: MessageConstants.horizontalPadding,
              vertical: MessageConstants.verticalPadding,
            ),
            decoration: const BoxDecoration(
              color: MessageConstants.backgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: MessageConstants.borderColor,
                  width: MessageConstants.borderWidth,
                ),
              ),
            ),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => _toggleEditMode(),
                  child: Text(
                    _isEditMode ? MessageConstants.doneText : MessageConstants.editButtonText,
                    style: const TextStyle(
                      color: MessageConstants.primaryColor,
                      fontSize: MessageConstants.buttonFontSize,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    MessageConstants.titleText,
                    style: const TextStyle(
                      color: MessageConstants.textColor,
                      fontSize: MessageConstants.titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () => _showAddContactDialog(context),
                  icon: const Icon(
                    Icons.add,
                    color: MessageConstants.primaryColor,
                    size: MessageConstants.appBarIconSize,
                  ),
                  tooltip: MessageConstants.addButtonTooltip,
                ),
              ],
            ),
          ),
          // 编辑模式提示
          if (_isEditMode)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(MessageConstants.horizontalPadding),
              color: Colors.orange.withOpacity(0.1),
              child: Text(
                '编辑模式：点击消息项可删除',
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: MessageConstants.messageFontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
          final message = _messages[index];
                final messageData = _messages[index];
                return _buildMessageItem(
                  avatar: messageData['isGroup'] 
                    ? _buildGroupAvatar(color: messageData['avatarColor'] ?? Colors.green)
                    : _buildSingleAvatar(hasPlus: messageData['hasPlus'] ?? false),
                  title: messageData['title'],
                  message: messageData['message'],
                  date: messageData['date'],
                  isGroup: messageData['isGroup'],
                  id: messageData['id'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem({
    required Widget avatar,
    required String title,
    required String message,
    required String date,
    required bool isGroup,
    String? id,
  }) {
    return InkWell(
      onTap: _isEditMode 
        ? () => _showDeleteConfirmDialog(id ?? '', title)
        : () => _showContactDialog(context, title, message, isGroup),
              child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: MessageConstants.horizontalPadding,
            vertical: MessageConstants.verticalPadding,
          ),
          decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(
                color: MessageConstants.borderColor,
                width: MessageConstants.borderWidth,
              ),
            ),
            color: _isEditMode ? Colors.red.withOpacity(0.1) : null,
          ),
        child: Row(
          children: [
            // 头像
            Stack(
              children: [
                avatar,
                if (isGroup)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: MessageConstants.smallAvatarSize,
                      height: MessageConstants.smallAvatarSize,
                      decoration: BoxDecoration(
                        color: MessageConstants.backgroundColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MessageConstants.backgroundColor,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: MessageConstants.smallIconSize,
                        color: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: MessageConstants.avatarSpacing),
            // 消息内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: MessageConstants.subtitleFontSize,
                      fontWeight: FontWeight.bold,
                      color: MessageConstants.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: MessageConstants.titleSpacing),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: MessageConstants.messageFontSize,
                      color: MessageConstants.subtitleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: MessageConstants.contentSpacing),
            // 时间
            Text(
              date,
              style: const TextStyle(
                fontSize: MessageConstants.dateFontSize,
                color: MessageConstants.subtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 显示添加联系人弹窗
  void _showAddContactDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController messageController = TextEditingController();
    bool isGroup = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                MessageConstants.addContactTitle,
                style: const TextStyle(
                  fontSize: MessageConstants.subtitleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: MessageConstants.contactNameLabel,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: MessageConstants.titleSpacing),
                  TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      labelText: MessageConstants.initialMessageLabel,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: MessageConstants.titleSpacing),
                  Row(
                    children: [
                      Text(MessageConstants.typeLabel),
                      const SizedBox(width: MessageConstants.contentSpacing),
                      ChoiceChip(
                        label: Text(MessageConstants.personalLabel),
                        selected: !isGroup,
                        onSelected: (selected) {
                          setState(() {
                            isGroup = !selected;
                          });
                        },
                      ),
                      const SizedBox(width: MessageConstants.contentSpacing),
                      ChoiceChip(
                        label: Text(MessageConstants.groupLabel),
                        selected: isGroup,
                        onSelected: (selected) {
                          setState(() {
                            isGroup = selected;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(MessageConstants.cancelText),
                ),
                TextButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty) {
                      // 添加新联系人到列表
                      _addNewContact(nameController.text, messageController.text, isGroup);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isGroup 
                            ? '${MessageConstants.groupAddedText}${nameController.text}'
                            : '${MessageConstants.contactAddedText}${nameController.text}'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(MessageConstants.pleaseEnterNameText),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child: Text(MessageConstants.addText),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 显示联系人弹窗
  void _showContactDialog(BuildContext context, String title, String message, bool isGroup) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            isGroup ? '群组信息' : '联系人信息',
            style: const TextStyle(
              fontSize: MessageConstants.subtitleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '名称: $title',
                style: const TextStyle(
                  fontSize: MessageConstants.messageFontSize,
                ),
              ),
              const SizedBox(height: MessageConstants.titleSpacing),
              Text(
                '最新消息: $message',
                style: const TextStyle(
                  fontSize: MessageConstants.messageFontSize,
                  color: MessageConstants.subtitleColor,
                ),
              ),
              const SizedBox(height: MessageConstants.titleSpacing),
              Text(
                '类型: ${isGroup ? "群组" : "个人"}',
                style: const TextStyle(
                  fontSize: MessageConstants.messageFontSize,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('关闭'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 这里可以添加发送消息的逻辑
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('正在打开聊天...'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: const Text('发送消息'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGroupAvatar({Color color = Colors.green}) {
    return Container(
      width: MessageConstants.avatarSize,
      height: MessageConstants.avatarSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.group,
        color: Colors.white,
        size: MessageConstants.iconSize,
      ),
    );
  }

  Widget _buildSingleAvatar({bool hasPlus = false}) {
    return Stack(
      children: [
        Container(
          width: MessageConstants.avatarSize,
          height: MessageConstants.avatarSize,
          decoration: const BoxDecoration(
            color: MessageConstants.primaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: MessageConstants.iconSize,
          ),
        ),
        if (hasPlus)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: MessageConstants.smallAvatarSize,
              height: MessageConstants.smallAvatarSize,
              decoration: const BoxDecoration(
                color: MessageConstants.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: MessageConstants.smallIconSize,
                color: MessageConstants.primaryColor,
              ),
            ),
          ),
      ],
    );
  }
} 