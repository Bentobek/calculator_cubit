import 'dart:async';

import 'package:calculator_cubit/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  Timer? _timer;

  void _startAction(VoidCallback action) {
    action();
    _timer = Timer.periodic(const Duration(milliseconds: 150), (_) => action());
  }

  void _stopAction() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cubit Counter (Hold to Repeat)")),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, count) {
            return Text(
              '$count',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTapDown: (_) => _startAction(() => context.read<CounterCubit>().decrement()),
            onTapUp: (_) => _stopAction(),
            onTapCancel: _stopAction,
            child: FloatingActionButton(
              heroTag: "decrement",
              onPressed: () {},
              child: const Icon(Icons.remove),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTapDown: (_) => _startAction(() => context.read<CounterCubit>().increment()),
            onTapUp: (_) => _stopAction(),
            onTapCancel: _stopAction,
            child: FloatingActionButton(
              heroTag: "increment",
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}