import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_to_do/data/repositories/auth_repository.dart';
import 'package:test_to_do/data/repositories/task_repository.dart';
import 'presentation/auth_bloc/auth_bloc.dart';
import 'presentation/auth_bloc/auth_scope_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final SharedPreferences sp = await SharedPreferences.getInstance();
  runApp(RepositoryProviders(sp: sp));
}

class RepositoryProviders extends StatelessWidget {
  const RepositoryProviders({
    super.key,
    required this.sp,
  });

  final SharedPreferences sp;

  @override
  Widget build(final BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository(sp: sp),
          ),
          RepositoryProvider<TaskRepository>(
            create: (context) => TaskRepository(sp: sp),
          ),
        ],
        child: const BlocProviders(),
      );
}

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            lazy: false,
            create: (context) => AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
          ),
        ],
        child: const TestToDoApp(),
      );
}

class TestToDoApp extends StatelessWidget {
  const TestToDoApp({super.key});

  @override
  Widget build(BuildContext context) => const ScreenUtilInit(
        designSize: Size(360, 690),
        child: MaterialApp(
          home: AuthScopePage(),
        ),
      );
}
