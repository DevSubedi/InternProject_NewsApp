abstract class AiRepository {
  Future<String> getAiSummary({required String content});
  Future getNewsContent({required String url});
}
