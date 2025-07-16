import '../../../utils/packages.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> productData;
  final String imagePath;

  const ResultScreen({
    Key? key,
    required this.productData,
    required this.imagePath,
  }) : super(key: key);

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final String message = widget.productData["message"] ?? "No message";
    final String data = widget.productData["data"] ?? "No analysis available";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(
                title: 'Scan Product',
                onPressed: () {
                  context.pushReplacement(Routes.BOTTOMNAV);
                },
              ),
              verticalSpace(context, 0.02),
              Center(
                child: Image.file(
                  File(widget.imagePath),
                  height: height(context) * 0.28,
                  width: width(context) * 0.6,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "Analysis:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                data,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
