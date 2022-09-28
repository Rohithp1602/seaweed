import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? textCancel;
  final String? textConfirm;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
    bool? isCancel = true;

  CustomDialog({
    required this.title,
    required this.description,
    this.textCancel,
    this.textConfirm,
    this.onCancel,
    this.onConfirm,
    this.isCancel = false,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        contentPadding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
        titlePadding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 8),
        title: Text(title ?? 'Alert'),
        content: Text(
          description ?? 'Description',
        ),
        actionsPadding: const EdgeInsetsDirectional.only(end: 8),
        actions: <Widget>[
          TextButton(
              child: Text(textConfirm ?? 'OK'),
              onPressed: () {
                onConfirm!.call();
              }),
          Visibility(
            visible: isCancel!,
            child: TextButton(
                child: Text(textCancel ?? 'Exit'),
                onPressed: () {
                 // exit(0);
                  onCancel!.call();
                }),
          )
        ],
      ),
    );
  }
}
