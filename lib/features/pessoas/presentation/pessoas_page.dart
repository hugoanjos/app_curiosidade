import 'package:flutter/material.dart';

class PessoasPage extends StatelessWidget {
  const PessoasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pessoas', style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
