import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marksheet_generator/view/result_view.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: "Marksheet Generator",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const ResultView(),
        },
      ),
    ),
  );
}
