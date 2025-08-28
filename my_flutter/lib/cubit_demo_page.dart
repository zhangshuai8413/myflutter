// cubit_demo_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. Cubit 状态定义
class CounterState {
  final int count;
  final bool isLoading;
  final String? error;

  CounterState({
    this.count = 0,
    this.isLoading = false,
    this.error,
  });

  CounterState copyWith({
    int? count,
    bool? isLoading,
    String? error,
  }) {
    return CounterState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// 2. Cubit 实现 - 直接通过方法改变状态
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState());

  // 直接调用方法，不需要事件
  void increment() {
    emit(state.copyWith(count: state.count + 1));
  }

  void decrement() {
    emit(state.copyWith(count: state.count - 1));
  }

  void reset() {
    emit(state.copyWith(count: 0));
  }

  // 异步操作
  Future<void> incrementAsync() async {
    emit(state.copyWith(isLoading: true, error: null));
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        count: state.count + 1,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}

// 3. 对比：Bloc 实现
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}
class DecrementEvent extends CounterEvent {}
class ResetEvent extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState()) {
    on<IncrementEvent>((event, emit) {
      emit(state.copyWith(count: state.count + 1));
    });
    
    on<DecrementEvent>((event, emit) {
      emit(state.copyWith(count: state.count - 1));
    });
    
    on<ResetEvent>((event, emit) {
      emit(state.copyWith(count: 0));
    });
  }
}

// 4. Cubit 演示页面
class CubitDemoPage extends StatelessWidget {
  const CubitDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cubit vs Bloc 对比演示'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Platform.isMacOS ? 32.0 : 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExplanation(),
              SizedBox(height: Platform.isMacOS ? 40.0 : 32.0),
              _buildCubitDemo(),
              SizedBox(height: Platform.isMacOS ? 40.0 : 32.0),
              _buildComparisonTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExplanation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cubit 是什么？',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Cubit 是 Bloc 的简化版本，去掉了 Event 概念，直接通过方法调用来改变状态。'
            '它更适合简单的状态管理场景，代码更简洁，学习成本更低。',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildCubitDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cubit 计数器演示',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<CounterCubit, CounterState>(
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    '当前计数: ${state.count}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: CircularProgressIndicator(),
                    ),
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '错误: ${state.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 400) {
                        // 窄屏幕：垂直排列
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () => context.read<CounterCubit>().decrement(),
                                  child: const Text('-1'),
                                ),
                                ElevatedButton(
                                  onPressed: () => context.read<CounterCubit>().reset(),
                                  child: const Text('重置'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () => context.read<CounterCubit>().increment(),
                                  child: const Text('+1'),
                                ),
                                ElevatedButton(
                                  onPressed: () => context.read<CounterCubit>().incrementAsync(),
                                  child: const Text('异步+1'),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        // 宽屏幕：水平排列
                        return Wrap(
                          spacing: Platform.isMacOS ? 12.0 : 8.0,
                          runSpacing: Platform.isMacOS ? 12.0 : 8.0,
                          alignment: WrapAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => context.read<CounterCubit>().decrement(),
                              child: const Text('-1'),
                            ),
                            ElevatedButton(
                              onPressed: () => context.read<CounterCubit>().reset(),
                              child: const Text('重置'),
                            ),
                            ElevatedButton(
                              onPressed: () => context.read<CounterCubit>().increment(),
                              child: const Text('+1'),
                            ),
                            ElevatedButton(
                              onPressed: () => context.read<CounterCubit>().incrementAsync(),
                              child: const Text('异步+1'),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cubit vs Bloc 对比',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),
          // 使用 LayoutBuilder 来获取可用宽度
          LayoutBuilder(
            builder: (context, constraints) {
              // 根据屏幕宽度决定使用表格还是卡片布局
              if (constraints.maxWidth < 600) {
                return _buildCardLayout();
              } else {
                return _buildTableLayout();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTableLayout() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(color: Colors.grey[300]!),
        columnSpacing: Platform.isMacOS ? 32.0 : 24.0,
        dataRowHeight: Platform.isMacOS ? 64.0 : 56.0,
        headingRowHeight: Platform.isMacOS ? 64.0 : 56.0,
        columns: const [
          DataColumn(
            label: Text('特性'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Bloc'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Cubit'),
            numeric: false,
          ),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text('事件处理')),
              DataCell(Text('需要定义 Event 类')),
              DataCell(Text('直接调用方法')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('复杂度')),
              DataCell(Text('较复杂')),
              DataCell(Text('简单')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('适用场景')),
              DataCell(Text('大型项目')),
              DataCell(Text('中小型项目')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('学习曲线')),
              DataCell(Text('陡峭')),
              DataCell(Text('平缓')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardLayout() {
    return Column(
      children: [
        _buildComparisonCard('事件处理', '需要定义 Event 类', '直接调用方法'),
        const SizedBox(height: 8),
        _buildComparisonCard('复杂度', '较复杂', '简单'),
        const SizedBox(height: 8),
        _buildComparisonCard('适用场景', '大型项目', '中小型项目'),
        const SizedBox(height: 8),
        _buildComparisonCard('学习曲线', '陡峭', '平缓'),
      ],
    );
  }

  Widget _buildComparisonCard(String feature, String blocValue, String cubitValue) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feature,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bloc:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[700],
                      ),
                    ),
                    Text(blocValue),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cubit:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.green[700],
                      ),
                    ),
                    Text(cubitValue),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 