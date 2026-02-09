import 'package:flutter/services.dart';
import 'package:greenzone_medical/src/features/account/model/submit_feedback_response.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';

class SubmitFeedbackPage extends ConsumerStatefulWidget {
  const SubmitFeedbackPage({super.key});

  @override
  ConsumerState<SubmitFeedbackPage> createState() => _SubmitFeedbackPageState();
}

class _SubmitFeedbackPageState extends ConsumerState<SubmitFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  final _locationController = TextEditingController();
  final _trackingIdController = TextEditingController();
  bool _isSubmitted = false;
  bool _isLoading = false;
  String? _selectedCategory = 'Suggestion';
  SubmitFeedbackResponse? result;

  final List<String> _categories = [
    'Suggestion',
    'Complaint',
  ];

  void trackFeedback(String trackId) async {
    context.pop();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    final response = await ref.read(authServiceProvider).trackFeedback(trackId);
    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      _trackingIdController.clear();
      context.push(Routes.TRACKFEEDBACKSCREEN, extra: response);
    }
  }

  void _submitFeedback() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    final body = {
      "type": _selectedCategory,
      "message": _feedbackController.text,
      "location": _locationController.text,
    };
    final response = await ref.read(authServiceProvider).submitFeedback(body);
    setState(() {
      _isSubmitted = true;
      result = response;
      if (response.isSuccess) {
        _feedbackController.clear();
        _locationController.clear();
      } else {
        context.showFeedBackDialog(message: response.error.toString());
      }
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _locationController.dispose();
    _trackingIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: 

      // AppBar(
      //   title: const Text(
      //     "Submit Feedback",
      //     style: TextStyle(
      //       color: Color(0xFF333333),
      //       fontSize: 16,
      //       fontWeight: FontWeight.w700,
      //     ),
      //   ),
      //   leading: (),
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   centerTitle: false,
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  title: 'Submit Feedback',
                ),
                20.height,
                const Text(
                  "Help us improve by reporting issues or\nsharing feedback.",
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                12.height,
                const Divider(color: Color(0xFFEEEEEE)),
                12.height,
                // Track Feedback Button
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: () {
                      _showTrackFeedbackBottomSheet();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: const Color(0xFFEAFFEA),
                    ),
                    child: const Text("Track Feedback"),
                  ),
                ),
                20.height,
            
                // Success Card
                if (_isSubmitted && result?.isSuccess == true) ...[
                  _showSubmittedCard(
                    context,
                    result: result,
                  ),
                  24.height,
                ],
            
                // Category Dropdown
                _buildLabel("Category"),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: _categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                    ),
                  ),
                ),
                16.height,
            
                // Description Field
                _buildLabel("Description"),
                const SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a description";
                    }
                    return null;
                  },
                  controller: _feedbackController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
                16.height,
            
                // Location Field
                _buildLabel("Location"),
                const SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a location";
                    }
                    return null;
                  },
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
                32.height,
            
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Submit Feedback",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                40.height,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTrackFeedbackBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('feedback'.toSvg),
              20.height,
              const Text(
                "Track Feedback",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF333333),
                ),
              ),
              8.height,
              const Text(
                "Enter your tracking ID to check\nthe status of your feedback",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF666666),
                ),
              ),
              24.height,
              Align(
                alignment: Alignment.centerLeft,
                child: _buildLabel("Tracking ID"),
              ),
              8.height,
              TextField(
                controller: _trackingIdController,
                decoration: InputDecoration(
                  hintText: "TCK3298J10R9R27382H43B198CNJDDJ",
                  hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              32.height,
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    trackFeedback(_trackingIdController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009900),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Track Feedback",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              16.height,
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "I'll do another time",
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              24.height,
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF888888),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _showSubmittedCard(BuildContext context,
      {SubmitFeedbackResponse? result}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAFFEA),
        border: Border.all(color: const Color(0xFF65D556)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 20),
              8.width,
              const Text(
                "Feedback Submitted",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF333333),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          12.height,
          Text(
            "Your tracking ID is:",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          8.height,
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFC7EBC4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  result?.data?.citizenFeedbackTrackId ?? '...',
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              8.width,
              InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                      text: result?.data?.citizenFeedbackTrackId ?? '',
                    ));
                    context.showFeedBackDialog(
                      message: 'Tracking ID copied to clipboard',
                      toastType: ToastType.success,
                    );
                  },
                  child: const Icon(Icons.copy, size: 18, color: Colors.green)),
            ],
          ),
          12.height,
          Text(
            "Please copy and save this ID. You may need it to track or follow up on your feedback",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
