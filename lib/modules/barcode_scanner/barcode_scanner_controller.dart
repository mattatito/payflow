import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

class BarcodeScannerController {
  final statusNotifier =
      ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());
  BarcodeScannerStatus get status => statusNotifier.value;
  set status(BarcodeScannerStatus status) => statusNotifier.value = status;

  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  void getAvailableCameras() async {
    try {
      final response = await availableCameras();
      final camera = response.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
      );

      final cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );
      await cameraController.initialize();
      status = BarcodeScannerStatus.availableCamera(cameraController);
      scanWithCamera();
    } catch (error) {
      status = BarcodeScannerStatus.error(error.toString());
    }
  }

  void scanWithCamera() {
    Future.delayed(Duration(seconds: 10)).then((value) {
      final cameraController = status.cameraController;
      if (cameraController != null &&
          cameraController.value.isStreamingImages) {
        cameraController.stopImageStream();
      }

      status = BarcodeScannerStatus.error("Timeout de leitura de boleto");
    });
    listenCamera();
  }

  void scanWithImagePicker() async {
    await status.cameraController!.stopImageStream();
    final response = await ImagePicker().pickImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarCode(inputImage);
  }

  void listenCamera() {
    if (status.cameraController != null) {
      if (status.cameraController!.value.isStreamingImages == false) {
        status.cameraController!.startImageStream((cameraImage) async {
          try {
            final WriteBuffer allBytes = WriteBuffer();
            for (Plane plane in cameraImage.planes) {
              allBytes.putUint8List(plane.bytes);
            }

            final bytes = allBytes.done().buffer.asUint8List();
            final Size imageSize = Size(
                cameraImage.width.toDouble(), cameraImage.height.toDouble());
            final InputImageRotation imageRotation =
                InputImageRotation.Rotation_0deg;
            final InputImageFormat inputImageFormat =
                InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
                    InputImageFormat.NV21;
            final planeData = cameraImage.planes
                .map((plane) => InputImagePlaneMetadata(
                    bytesPerRow: plane.bytesPerRow,
                    height: plane.height,
                    width: plane.width))
                .toList();

            final inputImageData = InputImageData(
              size: imageSize,
              imageRotation: imageRotation,
              inputImageFormat: inputImageFormat,
              planeData: planeData,
            );
            final inputImageCamera = InputImage.fromBytes(
              bytes: bytes,
              inputImageData: inputImageData,
            );

            await Future.delayed(Duration(seconds: 3));
            await scannerBarCode(inputImageCamera);
          } catch (error) {
            status = BarcodeScannerStatus.error(error.toString());
          }
        });
      }
    }
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      final cameraController = status.cameraController;
      if (cameraController != null) {
        if (cameraController.value.isStreamingImages)
          cameraController.stopImageStream();
      }

      final barcodes = await barcodeScanner.processImage(inputImage);
      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);
        if (cameraController != null) cameraController.dispose();
      } else {
        getAvailableCameras();
      }
    } catch (e) {
      status = BarcodeScannerStatus.error(e.toString());
      print("ERRO DA LEITURA $e");
    }
  }

  void dispose() {
    statusNotifier.dispose();
    barcodeScanner.close();
    if (status.showCamera) {
      status.cameraController!.dispose();
    }
  }
}
