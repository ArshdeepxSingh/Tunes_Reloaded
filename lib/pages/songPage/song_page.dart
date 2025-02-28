import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunes_reloaded/model/playlist_provider.dart';
import 'package:tunes_reloaded/theme/app_colors.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        // Get playlist
        final playlist = value.playlist;

        // Get current song index
        final currentSong = playlist[value.currentSongIndex ?? 0];

        // Get current playback position
        final currentPosition = value.currentPosition;
        final totalDuration = value.totalDuration;

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "Now Playing",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Album Artwork
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(currentSong.albumArtImagePath),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Song Title
                Text(
                  currentSong.songName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                // Artist Name
                Text(
                  currentSong.artistName,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),

                // Progress Bar
                Slider(
                  value: currentPosition.inSeconds.toDouble(),
                  min: 0,
                  max: totalDuration.inSeconds.toDouble(),
                  onChanged: (newValue) {
                    value.seek(Duration(seconds: newValue.toInt()));
                  },
                  activeColor: AppColors.primary,
                  inactiveColor: Colors.grey[700],
                ),

                // Time Stamps
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(currentPosition),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      formatDuration(totalDuration),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Playback Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
                      onPressed: value.playPrevious,
                    ),
                    IconButton(
                      icon: Icon(
                        value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                        color: AppColors.primary,
                        size: 60,
                      ),
                      onPressed: value.togglePlayPause,
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next, color: Colors.white, size: 40),
                      onPressed: value.playNext,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
