import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/modules/counter_screen/cubit/cubit.dart';
import 'package:to_do_app/modules/counter_screen/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text('Counter')),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => CounterCubit.get(context).minus(),
                    child: Text('minus'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  TextButton(
                    onPressed: () => CounterCubit.get(context).plus(),
                    child: Text('plus'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
