import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen>
    with SingleTickerProviderStateMixin {
  int selectedRating = 4;
  final TextEditingController feedbackController = TextEditingController();
  final int maxChars = 250;
  final List<bool> _starScaled = List.filled(5, false);

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Give Your Feedback",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Thanks for taking the time to tell us your thoughts, it means a lot to us.",
                style: TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 10),
              const Text(
                "If you have anymore to share, please add it below.",
                style: TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 20),
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // Set to index + 1 directly instead of toggling
                        selectedRating = index + 1;
                        _starScaled[index] = true;
                      });
                      Future.delayed(const Duration(milliseconds: 200), () {
                        setState(() => _starScaled[index] = false);
                      });
                    },
                    child: AnimatedScale(
                      scale: _starScaled[index] ? 1.3 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.star,
                        color:
                            index < selectedRating
                                ? Colors.amber
                                : Colors.grey[300],
                        size: 30,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  TextField(
                    controller: feedbackController,
                    maxLines: 5,
                    // Removed maxLength to avoid duplicate counters
                    decoration: InputDecoration(
                      hintText: "Penny for your thoughts?",
                      suffixIcon:
                          feedbackController.text.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  feedbackController.clear();
                                  setState(() {}); // Refresh character count
                                },
                              )
                              : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      counterText: "", // Hide the built-in counter
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 6),
                    child: Text(
                      "${feedbackController.text.length}/$maxChars",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final rating = selectedRating;
                    final feedback = feedbackController.text.trim();

                    if (feedback.isEmpty && rating == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please leave feedback or a rating."),
                        ),
                      );
                      return;
                    }

                    // Example submission behavior
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Thank you for your feedback!"),
                      ),
                    );

                    feedbackController.clear();
                    setState(() => selectedRating = 0);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF001B74),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 90,
                      vertical: 14,
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
