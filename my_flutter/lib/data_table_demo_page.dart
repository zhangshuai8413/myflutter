// data_table_demo_page.dart
import 'package:flutter/material.dart';

class DataTableDemoPage extends StatefulWidget {
  const DataTableDemoPage({Key? key}) : super(key: key);

  @override
  _DataTableDemoPageState createState() => _DataTableDemoPageState();
}

class _DataTableDemoPageState extends State<DataTableDemoPage> {
  // 排序相关状态
  int? _sortColumnIndex;
  bool _sortAscending = true;
  
  // 选择相关状态
  Set<DataRow> _selectedRows = {};
  
  // 分页相关状态
  int _rowsPerPage = 5;
  int _currentPage = 0;
  
  // 示例数据
  List<Map<String, dynamic>> _data = [
    {'name': '张三', 'age': 25, 'city': '北京', 'job': '工程师', 'salary': 15000},
    {'name': '李四', 'age': 30, 'city': '上海', 'job': '设计师', 'salary': 18000},
    {'name': '王五', 'age': 28, 'city': '广州', 'job': '产品经理', 'salary': 20000},
    {'name': '赵六', 'age': 32, 'city': '深圳', 'job': '架构师', 'salary': 25000},
    {'name': '钱七', 'age': 26, 'city': '杭州', 'job': '前端开发', 'salary': 16000},
    {'name': '孙八', 'age': 29, 'city': '成都', 'job': '后端开发', 'salary': 17000},
    {'name': '周九', 'age': 31, 'city': '武汉', 'job': '测试工程师', 'salary': 14000},
    {'name': '吴十', 'age': 27, 'city': '西安', 'job': '运维工程师', 'salary': 13000},
  ];

  List<DataRow> get _rows {
    List<Map<String, dynamic>> sortedData = List.from(_data);
    
    // 排序逻辑
    if (_sortColumnIndex != null) {
      sortedData.sort((a, b) {
        var aValue = a.values.elementAt(_sortColumnIndex!);
        var bValue = b.values.elementAt(_sortColumnIndex!);
        
        int comparison = 0;
        if (aValue is String && bValue is String) {
          comparison = aValue.compareTo(bValue);
        } else if (aValue is int && bValue is int) {
          comparison = aValue.compareTo(bValue);
        }
        
        return _sortAscending ? comparison : -comparison;
      });
    }
    
    // 分页逻辑
    int startIndex = _currentPage * _rowsPerPage;
    int endIndex = (startIndex + _rowsPerPage).clamp(0, sortedData.length);
    var pageData = sortedData.sublist(startIndex, endIndex);
    
    return pageData.map((row) {
      return DataRow(
        selected: _selectedRows.any((selectedRow) => 
          selectedRow.cells[0].child.toString().contains(row['name'])),
        onSelectChanged: (selected) {
          setState(() {
            var dataRow = DataRow(cells: [
              DataCell(Text(row['name'])),
              DataCell(Text(row['age'].toString())),
              DataCell(Text(row['city'])),
              DataCell(Text(row['job'])),
              DataCell(Text('¥${row['salary']}')),
            ]);
            
            if (selected!) {
              _selectedRows.add(dataRow);
            } else {
              _selectedRows.removeWhere((element) => 
                element.cells[0].child.toString().contains(row['name']));
            }
          });
        },
        cells: [
          DataCell(Text(row['name'])),
          DataCell(Text(row['age'].toString())),
          DataCell(Text(row['city'])),
          DataCell(Text(row['job'])),
          DataCell(Text('¥${row['salary']}')),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataTable 详细介绍'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 功能介绍区域
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'DataTable 功能特点',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('• 表格数据展示：以行和列的形式展示结构化数据'),
                const Text('• 排序功能：点击列头可进行升序/降序排序'),
                const Text('• 选择功能：支持单选和多选行数据'),
                const Text('• 分页显示：支持大量数据的分页展示'),
                const Text('• 自定义样式：可自定义颜色、字体、间距等'),
                const Text('• 响应式设计：支持水平滚动适应不同屏幕'),
              ],
            ),
          ),
          
          // 操作按钮区域
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text('已选择: ${_selectedRows.length} 行'),
                const Spacer(),
                ElevatedButton(
                  onPressed: _selectedRows.isEmpty ? null : () {
                    setState(() {
                      _selectedRows.clear();
                    });
                  },
                  child: const Text('清除选择'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _sortColumnIndex = null;
                      _sortAscending = true;
                    });
                  },
                  child: const Text('重置排序'),
                ),
              ],
            ),
          ),
          
          // 表格区域
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                // 排序相关
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                
                // 样式相关
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                ),
                dataTextStyle: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
                headingRowColor: MaterialStateProperty.all(Colors.blue),
                dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.blue.withOpacity(0.2);
                    }
                    return null;
                  },
                ),
                
                // 列定义
                columns: [
                  DataColumn(
                    label: const Text('姓名'),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = ascending;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('年龄'),
                    numeric: true,
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = ascending;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('城市'),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = ascending;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('职业'),
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = ascending;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text('薪资'),
                    numeric: true,
                    onSort: (columnIndex, ascending) {
                      setState(() {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = ascending;
                      });
                    },
                  ),
                ],
                
                // 数据行
                rows: _rows,
              ),
            ),
          ),
          
          // 分页控件
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('显示 ${_currentPage * _rowsPerPage + 1} - ${(_currentPage + 1) * _rowsPerPage} 条，共 ${_data.length} 条'),
                Row(
                  children: [
                    IconButton(
                      onPressed: _currentPage > 0 ? () {
                        setState(() {
                          _currentPage--;
                        });
                      } : null,
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Text('${_currentPage + 1} / ${(_data.length / _rowsPerPage).ceil()}'),
                    IconButton(
                      onPressed: _currentPage < (_data.length / _rowsPerPage).ceil() - 1 ? () {
                        setState(() {
                          _currentPage++;
                        });
                      } : null,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 