import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  final String imagePath;

  LoadingScreen({required this.imagePath});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _uploadImage();
  }

  Future<void> _uploadImage() async {
    final allService = ref.read(allServiceProvider);
    final result = await allService.imageAnalysis(File(widget.imagePath));

    if (result["code"] == 1) {
      context.push(
        Routes.PRODUCTSCANRESULT,
        extra: ScanResultArgs(
          imagePath: widget.imagePath,
          productData: result, // full map including 'data', 'message', etc.
        ),
      );
    } else {
      // Show error dialog or toast
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text(result["message"] ?? "Unknown error"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.file(
            File(widget.imagePath),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Loading_2.gif',
                height: 64,
                width: 64,
              ),
              tinySpace(),
              Text(
                'Loading...',
                style: TextStyle(color: Colors.white),
              )
            ],
          )),
        ],
      ),
    );
  }
}
