import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:html' as html;
import 'bloc/BlocEvent/sendbaecode.dart';
import 'bloc/Cubit/Rebuild.dart';
import 'widget/common/ComInputText.dart';
import 'widget/common/Loading.dart';
import 'widget/common/basicpopup.dart';

void main() {
  runApp(const MyApp());
}

bool undercontrol = false;
String BarcodeText = '';
late BuildContext maincon;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BlocPageRebuild>(
            create: (BuildContext context) =>
                BlocPageRebuild(), //For rebuild only page inside without app bar/left menu
          ),
        ],
        child: BlocBuilder<BlocPageRebuild, bool>(builder: (_, e) {
          return MaterialApp(
            title: 'Barcode Straightening',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: buffer01(),
          );
        }));
  }
}

class buffer01 extends StatelessWidget {
  const buffer01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SendBarcode_Bloc(),
        child: BlocBuilder<SendBarcode_Bloc, int>(
          builder: (context, page) {
            return MyHomePage();
          },
        ));
    ;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    maincon = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 200,
          width: 300,
          child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Text("Straightening Barcode Scanner"),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 45,
                  width: 250,
                  // color: Colors.amber,
                  child: ComInputText(
                    nLimitedChar: 24,
                    isContr: undercontrol,
                    fnContr: (input) {
                      setState(() {
                        undercontrol = input;
                      });
                    },
                    sValue: BarcodeText,
                    returnfunc: (String s) {
                      BarcodeText = s;
                    },
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 35,
                  child: ElevatedButton(
                    child: const Text('ENTER', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      // print(BarcodeText);
                      if (BarcodeText.length == 24) {
                        context.read<SendBarcode_Bloc>().add(SendBarcode_Pressed());
                        onLoadingType01(
                            context, () {}, BlocProvider.of<BlocPageRebuild>(context).rebuildPage());
                      } else {
                        basicpopup(context);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 250,
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text('CLEAR', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      // html.window.location.reload();
                      setState(() {
                        undercontrol = true;
                        BarcodeText = '';
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
