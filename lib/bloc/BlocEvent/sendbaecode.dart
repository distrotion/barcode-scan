import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../../main.dart';

//-------------------------------------------------

abstract class SendBarcode_Event {}

class SendBarcode_Pressed extends SendBarcode_Event {}

class SendBarcode_Bloc extends Bloc<SendBarcode_Event, int> {
  SendBarcode_Bloc() : super(0) {
    on<SendBarcode_Pressed>((event, emit) {
      return _SendBarcode_Function(0, emit);
    });
  }
  Future<void> _SendBarcode_Function(int toAdd, Emitter<int> emit) async {
    final response = await Dio().post(
      "http://172.23.10.60:1880/" + "bacodeST",
      data: {"barcode": BarcodeText},
    );
    emit(0);
  }
}
