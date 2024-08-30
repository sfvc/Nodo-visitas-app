import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/config/router/app_router.dart';
import 'package:nodo_app_2/feature/ingresos/providers/qr_form_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends ConsumerStatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  QrScannerWidgetState createState() => QrScannerWidgetState();
}

class QrScannerWidgetState extends ConsumerState<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  StreamSubscription? _scanSubscription;

  bool? isFlashOn;
  CameraFacing? cameraFacing;

  @override
  void initState() {
    super.initState();
    _initializeCameraState();
  }

  Future<void> _initializeCameraState() async {
    if (controller != null) {
      isFlashOn = await controller!.getFlashStatus();
      cameraFacing = await controller!.getCameraInfo();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        // backgroundColor: ,
        // title: Text(
        //   'Inicia tu viaje',
        //   style: subtitlesStyle!.copyWith(fontSize: 18, color: Colors.white),
        // ),
      ),
      body: Column(
        children: [
          Expanded(flex: 4, child: _buildQrView(context)),
          Container(
            alignment: Alignment.center,
            // color: colors.background,
            // flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (result != null)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Text(
                            'Escanea el codigo de DNI',
                            // style: subtitlesStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.pedal_bike_sharp,
                            // color: colors.primary,
                          )
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FilledButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            isFlashOn = await controller?.getFlashStatus();
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              isFlashOn == true
                                  ? const Icon(Icons.flash_off)
                                  : const Icon(Icons.flash_on),
                              const Text('Flash'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FilledButton(
                          onPressed: () async {
                            await controller?.flipCamera();
                            cameraFacing = await controller?.getCameraInfo();
                            setState(() {});
                          },
                          child: const Column(
                            children: [
                              SizedBox(height: 5),
                              Icon(Icons.flip_camera_ios_outlined),
                              Text('Camara'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FilledButton(
                          onPressed: () async {
                            controller?.dispose();
                            ref.read(goRouterProvider).go('/form-ingreso');
                          },
                          child: const Column(
                            children: [
                              SizedBox(height: 5),
                              Icon(Icons.edit_outlined),
                              Text('Escribir'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // CustomOutlineButtom(
                  //     text: 'Cancelar', onPressed: _cancelAndGoHome),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // void _cancelAndGoHome() {
  //   controller?.dispose();
  //   if (mounted) {
  //     ref.read(goRouterProvider).go('/');
  //   }
  // }

  Widget _buildQrView(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final scanAreaWidth = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 350.0;
    final scanAreaHeight = scanAreaWidth * 0.4;
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) => _onQRViewCreated(context, controller),
      overlay: QrScannerOverlayShape(
        borderColor: colors.primary,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 15,
        cutOutWidth: scanAreaWidth,
        cutOutHeight: scanAreaHeight,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    _scanSubscription = controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });

      if (scanData.code != null) {
        ref.read(qrFormProvider.notifier).setQRValue(scanData.code);
        ref.read(goRouterProvider).push('/test');
        controller.dispose();
        _scanSubscription?.cancel();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    controller?.dispose();
    super.dispose();
  }
}

// 00616920980@ALZUGARAY@JOSE MAXIMILIANO@M@41774207@B@09/02/1999@06/11/2019@208

// 00184253003@JALIL LEON@AGUSTIN@M@39017064@A@16/10/1996@22/04/2013

// 00273588515@ROBERT@ESTEBAN EDUARDO@M@40434082@A@21/06/1997@22/07/2014