import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  // 🔹 Update this ID when YouTube changes the live stream link
  static const String _videoId = '6w2aBDVct_w';

  late final YoutubePlayerController _yt;
  bool _keepAwake = true;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _yt = YoutubePlayerController.fromVideoId(
      videoId: _videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableCaption: true,
        strictRelatedVideos: true,
        playsInline: true,
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.live_tv, color: Colors.redAccent),
            const SizedBox(width: 8),
            Text(
              'Zad TV — Live',
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
            ),
          ],
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: YoutubePlayer(controller: _yt),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: const Color.fromARGB(255, 5, 3, 143),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.circle, size: 10, color: Colors.redAccent),
            const SizedBox(width: 6),
            Text('Live on Zad TV', style: GoogleFonts.openSans(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
