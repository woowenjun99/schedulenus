import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return const Card(
            child: ListTile(
              title: Text("This is some random text"),
              subtitle: Text("The subtitle text comes here"),
              trailing: Icon(Icons.abc),
            ),
          );
        },
      ),
    );
  }
}
