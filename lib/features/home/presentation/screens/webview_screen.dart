import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/injection.dart';
import 'package:news_app/features/ai/domain/repo/ai_repository.dart';
import 'package:news_app/features/ai/presentation/bloc/ai_summary_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  const WebviewScreen({super.key, required this.url});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AiSummaryBloc(getIt<AiRepository>())
            ..add(GetContentEvent(url: widget.url)),
      child: Scaffold(
        floatingActionButton: Builder(
          builder: (context) {
            return BlocConsumer<AiSummaryBloc, AiSummaryState>(
              listener: (context, state) {
                if (state.status == AiSummaryStatus.loaded) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'AI Summary',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              state.summary,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state.status == AiSummaryStatus.loading;

                return FloatingActionButton.extended(
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    final bloc = context.read<AiSummaryBloc>();
                    bloc.add(GetSummaryEvent(content: state.content));
                  },
                  icon: isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(Icons.auto_awesome, color: Colors.white),
                  label: Text(
                    isLoading ? 'Summarizing...' : 'AI Summary',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            );
          },
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        appBar: AppBar(
          title: Text(
            'News WebView',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
