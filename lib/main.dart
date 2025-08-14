import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZadTvApp());
}

class ZadTvApp extends StatelessWidget {
  const ZadTvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zad TV — Live',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007749), // subtle deep green
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF001C13),
      ),
      home: const LivePage(),
    );
  }
}

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  /// Zad TV live video ID from your link:
  /// https://www.youtube.com/live/9nXHHtalfV4?si=...
  static const String _videoId = '9nXHHtalfV4';

  late final YoutubePlayerController _yt;
  bool _keepAwake = true;

  @override
  void initState() {
    super.initState();

    // Keep screen on while watching
    WakelockPlus.enable();

    _yt = YoutubePlayerController.fromVideoId(
      videoId: _videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        // Keep the UI minimal but usable
        showControls: true,
        showFullscreenButton: true,
        enableCaption: false,
        // Only related from same channel when YT shows suggestions
        strictRelatedVideos: true,
        // Smooth inline playback on mobile
        playsInline: true,
        // Uses youtube-nocookie.com where supported
        // privacyEnhanced: true,
        // Optional: set your preferred interface language
        interfaceLanguage: 'en',
      ),
    );
  }

  @override
  void dispose() {
    _yt.close();
    WakelockPlus.disable();
    super.dispose();
  }

  Future<void> _toggleAwake() async {
    if (_keepAwake) {
      await WakelockPlus.disable();
    } else {
      await WakelockPlus.enable();
    }
    setState(() => _keepAwake = !_keepAwake);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zad TV — Live'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: _keepAwake ? 'Disable keep-awake' : 'Keep screen awake',
            icon: Icon(_keepAwake ? Icons.visibility : Icons.visibility_off),
            onPressed: _toggleAwake,
          ),
          IconButton(
            tooltip: 'Refresh stream',
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                _yt.loadVideoById(videoId: _videoId, startSeconds: 0),
          ),
        ],
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          // The IFrame player (no YouTube feed, comments, or recommendations UI)
          child: YoutubePlayer(controller: _yt),
        ),
      ),
      bottomNavigationBar: const SizedBox(height: 16),
    );
  }
}
