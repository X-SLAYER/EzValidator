import 'package:flutter/material.dart';

class ErrorWIdget extends StatelessWidget {
  final String? name;

  const ErrorWIdget({this.name, key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return name == null || name!.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 7.0),
              Row(
                children: [
                  const Icon(Icons.error_outline,
                      size: 14.0, color: Colors.red),
                  const SizedBox(width: 3.0),
                  Flexible(
                    child: Text(
                      name as String,
                      style: const TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                  )
                ],
              )
            ],
          );
  }
}
