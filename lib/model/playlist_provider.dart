import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tunes_reloaded/model/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: "Die with a smile",
      artistName: "Bruno Mars & Lady Gaga",
      albumArtImagePath:
          "assets/songs/covers/Die-With-A-Smile-Lady-Gaga-mp3-image-1.jpg",
      audioPath: "assets/songs/music/Die-With-A-Smile-Lady-Gaga.mp3",
    ),
    Song(
      songName: "Stronger",
      artistName: "Kanye West",
      albumArtImagePath: "assets/songs/covers/stronger.jpeg",
      audioPath: "assets/songs/music/Stronger.mp3",
    ),
    Song(
      songName: "Reminder",
      artistName: "The Weeknd",
      albumArtImagePath:
          "assets/songs/covers/The_Weeknd_-_Reminder_(Cover_Art).jpg",
      audioPath: "assets/songs/music/The Weeknd - Reminder.mp3",
    ),
    Song(
        songName: "Get Lucky",
        artistName: "Daft Punk feat. Pharell Williams",
        albumArtImagePath: "assets/songs/covers/RAM.png",
        audioPath: "assets/songs/music/Get Lucky.mp3")
  ];

  // Current song playing index
  int? _currentSongIndex;

  // Audio player instance
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // Constructor - start listening for duration updates
  PlaylistProvider() {
    listenToDuration();
  }

  // Initially, not playing
  bool _isPlaying = false;

  // Play the selected song
  Future<void> playSong(int index) async {
  if (index < 0 || index >= _playlist.length) return;

  _currentSongIndex = index;
  notifyListeners(); // Update UI before loading the song

  try {
    await _audioPlayer.setAsset(_playlist[index].audioPath); // Ensure song is loaded
    await _audioPlayer.play(); // Now play the song
    _isPlaying = true;
    notifyListeners();
  } catch (e) {
    print("Error playing song: $e");
  }
}


  // Pause the song
  Future<void> pauseSong() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume playing the song
  Future<void> resumeSong() async {
    await _audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  // Toggle between play and pause
  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await pauseSong();
    } else {
      await resumeSong();
    }
  }

  // Seek to a specific position in the song
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Play next song
  Future<void> playNext() async {
    if (_currentSongIndex == null || _currentSongIndex! >= _playlist.length - 1)
      return;
    playSong(_currentSongIndex! + 1);
  }

  // Play previous song
  Future<void> playPrevious() async {
    if (_currentSongIndex == null || _currentSongIndex! <= 0) return;
    playSong(_currentSongIndex! - 1);
  }

  // Listen to song duration and updates
  void listenToDuration() {
    // Listen for total song duration
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        _totalDuration = duration;
        notifyListeners();
      }
    });

    // Listen for current playback position
    _audioPlayer.positionStream.listen((position) {
      _currentDuration = position;
      notifyListeners();
    });

    // Listen for song completion and play the next song
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
    });
  }

  // Dispose audio player when not needed
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // GETTERS
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  Song get currentSong => _playlist[_currentSongIndex ?? 0];
  bool get isPlaying => _isPlaying;
  Duration get currentPosition => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // SETTER for current song index
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    notifyListeners();
  }
}
