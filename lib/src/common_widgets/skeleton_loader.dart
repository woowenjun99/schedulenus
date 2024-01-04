import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          thickness: 0.3,
          color: Colors.black38,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          return const ListTile(
            title: Text("This is some random text"),
            subtitle: Text("The subtitle text comes here"),
            trailing: Icon(Icons.abc),
          );
        },
      ),
    );
  }
}
