import 'package:flutter/material.dart';
import 'package:flutter_advanced_concepts/providers/position_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {

  double left = 300;
  double top = 600;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: GestureDetector(
            onTap: () {
              context.push('/login');
            },
            child: const Center(
              child: Text("Welcome"),
            ),
          ),
        ),

        Consumer<PositionProvider>(
          builder: (_, provider, __) {
            return Positioned(
              left: provider.left,
              top: provider.top,
              child: GestureDetector(
                onPanUpdate: (details) {
                  provider.updatePosition(
                    details.delta.dx,
                    details.delta.dy,
                    MediaQuery.of(context).size.height,
                    MediaQuery.of(context).size.width,
                  );
                },
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              ),
            );
          },
        ),
      ],
    );
  }}