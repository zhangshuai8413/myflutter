// login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. 事件定义
abstract class LoginEvent {}

class UsernameChanged extends LoginEvent {
  final String username;
  UsernameChanged(this.username);
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {}

// 2. 状态定义
enum LoginStatus { initial, submitting, success, failure }

class LoginState {
  final String username;
  final String password;
  final LoginStatus status;
  final String? errorMessage;

  LoginState({
    this.username = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    String? username,
    String? password,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

// 3. Bloc 实现
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<UsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.submitting, errorMessage: null));
      await Future.delayed(Duration(seconds: 1));
      if (state.username == 'admin' && state.password == '123456') {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: '用户名或密码错误',
        ));
      }
    });
  }
}

// 4. 登录页 UI
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('登录')),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: '用户名'),
                    onChanged: (value) => context.read<LoginBloc>().add(UsernameChanged(value)),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(labelText: '密码'),
                    obscureText: true,
                    onChanged: (value) => context.read<LoginBloc>().add(PasswordChanged(value)),
                  ),
                  const SizedBox(height: 24),
                  if (state.status == LoginStatus.failure)
                    Text(state.errorMessage ?? '', style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: state.status == LoginStatus.submitting
                        ? null
                        : () => context.read<LoginBloc>().add(LoginSubmitted()),
                    child: state.status == LoginStatus.submitting
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('登录'),
                  ),
                  if (state.status == LoginStatus.success)
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text('登录成功！', style: TextStyle(color: Colors.green)),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
} 