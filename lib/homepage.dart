import 'package:bloc_to_bloc_communication/blocs/color/color_bloc.dart';
import 'package:bloc_to_bloc_communication/blocs/counter/counter_bloc.dart';
import 'package:bloc_to_bloc_communication/observers/color_bloc_ovserver.dart';
import 'package:bloc_to_bloc_communication/observers/counter_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlocOverrides.runZoned(
        () => context.watch<ColorBloc>().state.color,
        blocObserver: ColorBlocObserver(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ColorBloc>().add(ChangeColorEvent());
              },
              child: const Text(
                "Change Color",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            BlocOverrides.runZoned(
              () {
                return Text(
                  "${context.watch<CounterBloc>().state.counter}",
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
              blocObserver: CounterBlocObserver(),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CounterBloc>().add(ChangeCounterEvent());
              },
              child: const Text(
                "Increment Counter",
                style: TextStyle(fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }
}
