import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:typed_data';
import 'package:calm_addict_flutter/providers/providers.dart'; // Adjust the import path accordingly

class MeditationPlayer extends ConsumerStatefulWidget {
  const MeditationPlayer({Key? key}) : super(key: key);

  @override
  ConsumerState<MeditationPlayer> createState() => _MeditationPlayerState();
}

class _MeditationPlayerState extends ConsumerState<MeditationPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  /// Calls the repository to get the audio file for meditation_level = 1,
  /// then plays the audio from the retrieved bytes.
  Future<void> _playMeditation() async {
    // Retrieve the repository from Riverpod.
    final meditationRepository = ref.read(meditationRepositoryProvider);

    // Retrieve the audio file as bytes from Supabase/Firebase Storage.
    final Uint8List? fileData =
        await meditationRepository.getMeditationAudioFile(meditationLevel: 1);

    if (fileData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meditation audio not found')),
      );
      return;
    }

    try {
      // Play the audio from the bytes.
      // (Note: The API might differ slightly depending on your audioplayers version.)
      await _audioPlayer.play(BytesSource(fileData));
      setState(() {
        _isPlaying = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meditation is playing')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing meditation: $e')),
      );
    }
  }

  /// Stops the currently playing meditation.
  Future<void> _stopMeditation() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _playMeditation,
              child: const Text('Play Meditation (Level 1)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _stopMeditation,
              child: const Text('Stop Meditation'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back.
                context.pop();
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
