import 'package:flutter/material.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeControler controller;

  @override
  void initState() {
    controller = HomeControler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              controller.getSnack();
            },
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              controller.getError();
            },
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              controller.getData();
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BuildController<HomeState>(
        state: controller,
        listeners: {
          Snack: (state, context) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Casa')));
          },
        },
        actions: {
          Loading: (state) => const Center(child: CircularProgressIndicator()),
          Error: (state) => const Center(child: Text('Ops, something is Wrong.')),
          Loaded: (state) {
            var st = state as Loaded;
            return ListView.builder(
              itemCount: st.data.length,
              itemBuilder: (context, index) => ListTile(title: Text(st.data[index])),
            );
          },
        },
      ),
    );
  }
}

class BuildController<T> extends StatefulWidget {
  final Map<Type, Widget Function(T state)> actions;
  final Map<Type, void Function(T state, BuildContext context)>? listeners;
  final ValueNotifier<T> state;
  const BuildController({
    Key? key,
    required this.actions,
    this.listeners,
    required this.state,
  }) : super(key: key);

  @override
  State<BuildController<T>> createState() => _BuildControllerState<T>();
}

class _BuildControllerState<T> extends State<BuildController<T>> {
  @override
  void initState() {
    super.initState();
    widget.state.addListener(() {
      var action = widget.listeners?[widget.state.value.runtimeType];
      if (action != null) {
        action(widget.state.value, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget oldChild = const SizedBox();
    return ValueListenableBuilder<T>(
        valueListenable: widget.state,
        builder: (context, value, child) {
          var action = widget.actions[value.runtimeType];
          if (action != null) {
            oldChild = action(value);
          }
          return oldChild;
        });
  }
}
