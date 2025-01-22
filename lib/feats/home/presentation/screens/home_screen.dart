import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sensor_animation/core/router.dart';

final List<Paths> _paths = [
  Paths.sensor,
  Paths.parallex,
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          itemCount: _paths.length,
          itemBuilder: (context, index) => ListTile(
            title: Text('${_paths[index].name}으로 이동'),
            onTap: () => context.goNamed(_paths[index].name),
            tileColor: Colors.grey[200],
          ),
        ));
  }
}
