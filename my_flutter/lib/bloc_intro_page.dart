// bloc_intro_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc 事件
abstract class InputEvent {}
class UpdateInput extends InputEvent {
  final String value;
  UpdateInput(this.value);
}

// Bloc 状态
class InputState {
  final String value;
  InputState({required this.value});
}

// Bloc 实现
class InputBloc extends Bloc<InputEvent, InputState> {
  InputBloc() : super(InputState(value: '')) {
    on<UpdateInput>((event, emit) {
      emit(InputState(value: event.value));
    });
  }
}

// 页面演示
class BlocIntroPage extends StatelessWidget {
  const BlocIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InputBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Bloc 值传递演示')),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '输入内容并通过 Bloc 传递，实时显示：',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _ValueInputWidget(),
              const SizedBox(height: 32),
              const Text('Bloc 当前值：', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              BlocBuilder<InputBloc, InputState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      state.value.isEmpty ? '（暂无）' : state.value,
                      style: const TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ValueInputWidget extends StatefulWidget {
  @override
  State<_ValueInputWidget> createState() => _ValueInputWidgetState();
}

class _ValueInputWidgetState extends State<_ValueInputWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: '请输入内容',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            context.read<InputBloc>().add(UpdateInput(_controller.text));
          },
          child: const Text('提交'),
        ),
      ],
    );
  }
} 