import 'dart:developer';

import 'package:bloc_to_bloc_communication/blocs/color/color_bloc.dart';
import 'package:bloc_to_bloc_communication/blocs/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int incrementSize = 1;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ColorBloc, ColorState>(
      listener: (context, colorState) {
        if (colorState.color == Colors.red) {
          incrementSize = 1;
        } else if (colorState.color == Colors.green) {
          incrementSize = 10;
        } else if (colorState.color == Colors.blue) {
          incrementSize = 50;
        } else if (colorState.color == Colors.black) {
          incrementSize = -100;
          context
              .read<CounterBloc>()
              .add(ChangeCounterEvent(incrementSize: incrementSize));
        }
      },
      child: Scaffold(
        backgroundColor: context.watch<ColorBloc>().state.color,
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
              Text(
                "${context.watch<CounterBloc>().state.counter}",
                style: const TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<CounterBloc>()
                      .add(ChangeCounterEvent(incrementSize: incrementSize));
                },
                child: const Text(
                  "Increment Counter",
                  style: TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
