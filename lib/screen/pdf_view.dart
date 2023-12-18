import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  final String value;
  const PdfView({
    Key? key,
    required this.value,

  }) : super(key: key);


  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {

  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    print(widget.value.toString());
    print("He");
    return SafeArea(
        child: Scaffold(
          body: SfPdfViewer.network(
              widget.value.toString(),
              controller: _pdfViewerController,
              key: _pdfViewerStateKey),
          appBar: AppBar(
            title: Text("Manual"),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    _pdfViewerStateKey.currentState!.openBookmarkView();
                  },
                  icon: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    _pdfViewerController.jumpToPage(5);
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    _pdfViewerController.zoomLevel = 1.25;
                  },
                  icon: Icon(
                    Icons.zoom_in,
                    color: Colors.white,
                  ))
            ],
          ),
        ));
  }
}
