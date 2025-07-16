import '../../../utils/packages.dart';

class ProductScanScreen extends StatefulWidget {
  const ProductScanScreen({super.key});

  @override
  _ProductScanScreenState createState() => _ProductScanScreenState();
}

class _ProductScanScreenState extends State<ProductScanScreen> {
  CameraController? _cameraController;
  bool _isScanning = true;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _cameraController =
          CameraController(cameras.first, ResolutionPreset.high);
      await _cameraController!.initialize();
      setState(() {});
    } catch (e) {
      debugPrint("Camera initialization error: $e");
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    final image = await _cameraController!.takePicture();
    _showLoadingAndUpload(image);
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _showLoadingAndUpload(XFile(pickedFile.path));
    }
  }

  void _showLoadingAndUpload(XFile image) {
    context.push(Routes.LOADINGPRODUCTSCAN, extra: image.path);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          CameraPreview(_cameraController!),

          // Transparent overlay with buttons
          Container(
            color: Colors.black.withOpacity(0.4),
            child: SafeArea(
              child: Stack(
                children: [
                  // Close button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // Buttons at the bottom
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _pickImageFromGallery,
                            icon: const Icon(Icons.image),
                            label: const Text('Gallery'),
                          ),
                          ElevatedButton.icon(
                            onPressed: _takePicture,
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Take Shot'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
