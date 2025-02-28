import 'package:flutter/material.dart';
import 'package:tunes_reloaded/model/playlist_provider.dart';
import 'package:tunes_reloaded/model/song.dart';
import 'package:tunes_reloaded/pages/home/drawer.dart';
import 'package:tunes_reloaded/pages/songPage/song_page.dart';
import 'package:tunes_reloaded/theme/app_colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Navigate to the Song Page
     void goToSong(BuildContext context, int songIndex) {
      // Get the PlaylistProvider
      final playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);

      // Update the current song index
      playlistProvider.currentSongIndex = songIndex;

      // Navigate to the song page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SongPage()),
      );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark // Dark mode color
            : AppColors.light, // Light mode color
        title: const Text("Your Songs"),
      ),
      drawer: const AppDrawer(),

      body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {
          // Get the playlist from the provider
          final List<Song> playlist = playlistProvider.playlist;

          // Return ListView UI with the playlist songs
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              // Get individual song from playlist
              final Song song = playlist[index];

              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(context, index), // Navigate to the song
              );
            },
          );
        },
      ),
    );
  }
}
