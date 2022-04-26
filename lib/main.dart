import 'package:bloc_to_bloc_communication/blocs/color/color_bloc.dart';
import 'package:bloc_to_bloc_communication/blocs/counter/counter_bloc.dart';
import 'package:bloc_to_bloc_communication/homepage.dart';
import 'package:bloc_to_bloc_communication/observers/color_bloc_ovserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // BlocOverrides.runZoned(
  //   () {
  //     runApp(const MyApp());
  //   },
  //   blocObserver: ColorBlocObserver(),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorBloc>(create: (context) => ColorBloc()),
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(
            colorBloc: context.read<ColorBloc>(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "bloc to bloc communication",
        theme: ThemeData(primarySwatch: Colors.green),
        home: const HomePage(),
      ),
    );
  }
}
