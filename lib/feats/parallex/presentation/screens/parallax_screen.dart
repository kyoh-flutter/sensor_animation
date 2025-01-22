import 'package:flutter/material.dart';
import 'package:sensor_animation/feats/parallex/presentation/widgets/parallax_cards.dart';

class ParallaxScreen extends StatelessWidget {
  const ParallaxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parallax Screen'),
      ),
      body: const ParallaxCards(
        imagesList: [
          NetworkImage('https://picsum.photos/800', headers: {'a': 'a'}),
          NetworkImage('https://picsum.photos/400', headers: {'a': 'b'}),
          NetworkImage('https://picsum.photos/600', headers: {'a': 'c'}),
          NetworkImage('https://picsum.photos/700', headers: {'a': 'd'}),
          NetworkImage('https://picsum.photos/1000', headers: {'a': 'e'}),
          NetworkImage('https://picsum.photos/430', headers: {'a': 'f'}),
          NetworkImage('https://picsum.photos/440', headers: {'a': 'g'}),
          NetworkImage('https://picsum.photos/3200', headers: {'a': 'j'}),
          NetworkImage('https://picsum.photos/1200', headers: {'a': 's'}),
        ],
      ),
    );
  }
}
