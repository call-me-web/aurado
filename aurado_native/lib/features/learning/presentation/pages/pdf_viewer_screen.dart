import 'package:aurado/features/learning/domain/models/lesson_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewerScreen extends StatelessWidget {
  final String title;
  final String url;
  final bool isDownloadable;

  const PdfViewerScreen({
    super.key,
    required this.title,
    required this.url,
    this.isDownloadable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (isDownloadable)
            IconButton(
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedDownload01,
                size: 20,
              ),
              onPressed: () async {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              tooltip: 'Download PDF',
            ),
        ],
      ),
      body: SfPdfViewer.network(
        url,
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}
