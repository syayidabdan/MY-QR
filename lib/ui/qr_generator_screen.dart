import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  String? qrRawValue;
  Color qrColor = Colors.white;
  final List<String> qrTypes = ["JPG", "PNG", "SVG", "PDF"];
  String? selectedQrType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create QR Code",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E3B55),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF232526), Color(0xFF414345)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // QR Code preview section
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: qrRawValue == null
                          ? LinearGradient(
                              colors: [Colors.grey[300]!, Colors.grey[400]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [Colors.blue[100]!, Colors.blue[300]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Screenshot(
                      controller: screenshotController,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: qrRawValue == null
                            ? null
                            : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: qrColor, width: 5),
                              ),
                        child: qrRawValue == null
                            ? const Text(
                                "No QR Code Generated",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            : PrettyQr(
                                data: qrRawValue!,
                                size: 150,
                                roundEdges: true,
                                elementColor: Colors.black,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Input field for QR code value
                Text(
                  "Enter your link:",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Link",
                    hintText: "Insert link here...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      qrRawValue = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Dropdown to select QR type
                Text(
                  "Select QR Code Type:",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 56),
                  child: DropdownButtonHideUnderline(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: selectedQrType,
                        hint: const Text('Select QR Code Type'),
                        isExpanded: true,
                        isDense: true,
                        items: qrTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedQrType = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Color palette for QR code background
                Text(
                  "Pick a background color:",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var color in [
                      Colors.grey,
                      Colors.orange,
                      Colors.yellow,
                      Colors.green,
                      Colors.cyan,
                      Colors.purple
                    ])
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            qrColor = color;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: qrColor == color
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),

                // Action buttons (Cancel and Share)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            qrRawValue = null;
                          });
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          _shareQrCode();
                        },
                        child: const Text(
                          "Share",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareQrCode() async {
    final image = await screenshotController.capture();
    if (image != null) {
      await Share.shareXFiles([
        XFile.fromData(
          image,
          name: "qr_code.png",
          mimeType: "image/png",
        ),
      ]);
    }
  }
}
