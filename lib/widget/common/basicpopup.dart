import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//------------------------------------

import '../../bloc/cubit/Rebuild.dart';

void basicpopup(BuildContext contextin) {
  showDialog(
    context: contextin,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Container(
        // color: Colors.red,

        child: Dialog(
          child: Container(
              height: 75,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 30),
                  Text("BACODE INCORRECT"),
                  SizedBox(width: 20),
                ],
              )),
        ),
      );
    },
  );
}
