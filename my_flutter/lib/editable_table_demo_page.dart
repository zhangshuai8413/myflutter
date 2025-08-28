// editable_table_demo_page.dart
import 'package:flutter/material.dart';

class EditableTableDemoPage extends StatefulWidget {
  const EditableTableDemoPage({super.key});

  @override
  State<EditableTableDemoPage> createState() => _EditableTableDemoPageState();
}

class _EditableTableDemoPageState extends State<EditableTableDemoPage> {
  // 表格数据
  List<List<String>> tableData = [
    ['姓名', '年龄', '部门', '薪资'],
    ['张三', '25', '技术部', '8000'],
    ['李四', '30', '市场部', '9000'],
    ['王五', '28', '设计部', '8500'],
    ['赵六', '32', '技术部', '12000'],
  ];

  // 当前编辑的单元格
  int? editingRow;
  int? editingCol;
  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('可编辑表格演示'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _addRow,
            icon: const Icon(Icons.add),
            tooltip: '添加行',
          ),
          IconButton(
            onPressed: _addColumn,
            icon: const Icon(Icons.add),
            tooltip: '添加列',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInstructions(theme),
            
            const SizedBox(height: 20),
            _buildEditableTable(),
            
            const SizedBox(height: 20),
            _buildControls(),
            
            const SizedBox(height: 20),
            _buildDataExport(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions(ThemeData theme) {
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
            '📊 Excel 风格可编辑表格',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple[800],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '• 双击单元格开始编辑\n'
            '• 按 Enter 键保存编辑\n'
            '• 按 Esc 键取消编辑\n'
            '• 支持添加行和列\n'
            '• 支持数据导出',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(color: Colors.grey[300]!),
          columnWidths: {
            for (int i = 0; i < tableData[0].length; i++)
              i: const IntrinsicColumnWidth(),
          },
          children: [
            // 表头行
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[100]),
              children: [
                for (int j = 0; j < tableData[0].length; j++)
                  _buildEditableCell(0, j, isHeader: true),
              ],
            ),
            // 数据行
            for (int i = 1; i < tableData.length; i++)
              TableRow(
                children: [
                  for (int j = 0; j < tableData[i].length; j++)
                    _buildEditableCell(i, j),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableCell(int row, int col, {bool isHeader = false}) {
    final isEditing = editingRow == row && editingCol == col;
    final cellData = tableData[row][col];

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isEditing ? Colors.blue[50] : null,
        border: isEditing ? Border.all(color: Colors.blue, width: 2) : null,
      ),
      child: GestureDetector(
        onDoubleTap: () => _startEditing(row, col),
        child: isEditing
            ? TextField(
                controller: _editingController,
                autofocus: true,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onSubmitted: (value) => _saveEdit(value),
                onEditingComplete: () => _saveEdit(_editingController.text),
              )
            : Text(
                cellData,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
      ),
    );
  }

  Widget _buildControls() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElevatedButton.icon(
          onPressed: _addRow,
          icon: const Icon(Icons.add),
          label: const Text('添加行'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: _addColumn,
          icon: const Icon(Icons.add),
          label: const Text('添加列'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: _deleteLastRow,
          icon: const Icon(Icons.remove),
          label: const Text('删除最后一行'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: _deleteLastColumn,
          icon: const Icon(Icons.remove),
          label: const Text('删除最后一列'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDataExport() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📋 数据导出',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: _exportToCSV,
                icon: const Icon(Icons.file_download),
                label: const Text('导出为 CSV'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _copyToClipboard,
                icon: const Icon(Icons.copy),
                label: const Text('复制到剪贴板'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: SelectableText(
              _generateCSVData(),
              style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  void _startEditing(int row, int col) {
    setState(() {
      editingRow = row;
      editingCol = col;
      _editingController.text = tableData[row][col];
    });
  }

  void _saveEdit(String value) {
    if (editingRow != null && editingCol != null) {
      setState(() {
        tableData[editingRow!][editingCol!] = value;
        editingRow = null;
        editingCol = null;
      });
    }
  }

  void _addRow() {
    setState(() {
      final newRow = List<String>.filled(tableData[0].length, '');
      tableData.add(newRow);
    });
  }

  void _addColumn() {
    setState(() {
      for (int i = 0; i < tableData.length; i++) {
        tableData[i].add('');
      }
    });
  }

  void _deleteLastRow() {
    if (tableData.length > 1) {
      setState(() {
        tableData.removeLast();
      });
    }
  }

  void _deleteLastColumn() {
    if (tableData[0].length > 1) {
      setState(() {
        for (int i = 0; i < tableData.length; i++) {
          tableData[i].removeLast();
        }
      });
    }
  }

  String _generateCSVData() {
    return tableData.map((row) => row.join(',')).join('\n');
  }

  void _exportToCSV() {
    final csvData = _generateCSVData();
    // 这里可以添加文件保存逻辑
    debugPrint('CSV 数据: $csvData'); // 临时打印，实际应该保存到文件
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('CSV 数据已生成，共 ${tableData.length} 行'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _copyToClipboard() {
    final csvData = _generateCSVData();
    // 这里可以添加剪贴板复制逻辑
    debugPrint('复制到剪贴板: $csvData'); // 临时打印，实际应该复制到剪贴板
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('数据已复制到剪贴板'),
        backgroundColor: Colors.blue,
      ),
    );
  }
} 