import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/export/core_export.dart';

class SoundController extends GetxController with WidgetsBindingObserver {
  final AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayerBackground = AudioPlayer();
  final AudioPlayer audioPlayGame = AudioPlayer();
  Rx<bool> isPlayMusic = false.obs;

  final String _assetPathSound = 'assets/features/';
  final String _backgroundSoundName = 'background_sound.mp3';
  final String _chooseHomeSoundName = 'home_choose_sound.mp3';
  final String _chooseGameSoundName = 'game_choose_sound_.mp3';
  final String _chooseLevelSoundName = 'level_choose_sound.mp3';
  final String _answerCorrectSoundName = 'true_sound.mp3';
  final String _answerWrongSoundName = 'false_sound.mp3';
  final String _playSoundName = 'play_sound.mp3';
  final String _clickBackName = 'click_back_sound.mp3';
  final String _clickCloseName = 'click_close_sound.mp3';
  final String _clickDoneName = 'click_done_sound.mp3';
  final String _clickPremiumName = 'click_premium_sound.mp3';

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    audioPlayer.onPlayerStateChanged.listen((event) {});
    super.onInit();
    playBackgroundSound();
    isPlayMusic = false.obs;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    isPlayMusic = false.obs;
    audioPlayer.dispose();
    audioPlayGame.dispose();
    audioPlayerBackground.dispose();
    super.onClose();
  }

  ///
  /// Play music audio sound.
  ///
  void playBackgroundSound() {
    if (sl<SharedPreferenceHelper>().getPlayMusic) {
      audioPlayerBackground.audioCache.prefix = _assetPathSound;
      // lặp lại vô hạn đến khi người dùng tắt âm thanh
      audioPlayerBackground.setReleaseMode(ReleaseMode.loop);
      audioPlayerBackground.seek(const Duration());
      audioPlayerBackground.play(AssetSource(_backgroundSoundName), volume: 7);
      isPlayMusic.value = true;
    } else {
      audioPlayerBackground.pause();
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    log('state: $state');
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      pauseBackgroundSound();
      pauseSoundGame();
    }
    if (state == AppLifecycleState.resumed) {
      continueBackgroundSound();
    }
  }

  ///
  /// Play click play game sound.
  ///
  void playPlaySound() {
    if (sl<SharedPreferenceHelper>().getPlayMusic) {
      audioPlayGame.audioCache.prefix = _assetPathSound;
      audioPlayGame.setReleaseMode(ReleaseMode.loop);

      audioPlayGame.seek(const Duration());
      audioPlayGame.play(AssetSource(_playSoundName), volume: .99);
    } else {
      audioPlayGame.pause();
    }
  }

  ///
  /// Play click back game true sound.
  ///
  void playClickBackSound() {
    if (sl<SharedPreferenceHelper>().getPlaySound) {
      audioPlayer.audioCache.prefix = _assetPathSound;
      audioPlayer.seek(const Duration());
      audioPlayer.play(AssetSource(_clickBackName), volume: .7);
    }
  }

  ///
  /// Play click done result true sound.
  ///
  void playClickDoneSound() {
    if (sl<SharedPreferenceHelper>().getPlaySound) {
      audioPlayer.audioCache.prefix = _assetPathSound;
      audioPlayer.seek(const Duration());
      audioPlayer.play(AssetSource(_clickDoneName), volume: .7);
    }
  }

  ///
  /// Play click answer true sound.
  ///
  void playClickCloseSound() {
    if (sl<SharedPreferenceHelper>().getPlaySound) {
      audioPlayer.audioCache.prefix = _assetPathSound;
      audioPlayer.seek(const Duration());
      audioPlayer.play(AssetSource(_clickCloseName), volume: .7);
    }
  }

  void playClickPremiumSound() {
    if (sl<SharedPreferenceHelper>().getPlaySound) {
      audioPlayer.audioCache.prefix = _assetPathSound;
      audioPlayer.seek(const Duration());
      audioPlayer.play(AssetSource(_clickPremiumName), volume: .7);
    }
  }

  ///
  /// Play click answer true sound.
  ///
  void playAnswerTrueSound() {
    if (sl<SharedPreferenceHelper>().getPlaySound) {
      audioPlayer.audioCache.prefix = _assetPathSound;
      audioPlayer.seek(const Duration());
      audioPlayer.play(AssetSource(_answerCorrectSoundName), volume: .7);
    }
  }

  ///
  /// Play click answer true sound.
  ///
  void playAnswerFalseSound() {
    if (sl<SharedPreferenceHelper>().getPlaySound) {
      audioPlayer.audioCache.prefix = _assetPathSound;
      audioPlayer.seek(const Duration());
      audioPlayer.play(AssetSource(_answerWrongSoundName), volume: .7);
    }
  }

  ///
  /// Play click level sound.
  ///
  void playClickLevelSound() {
    if (sl<SharedPreferenceHelper>().getPlaySound) {
      audioPlayer.audioCache.prefix = _assetPathSound;
      audioPlayer.seek(const Duration());
      audioPlayer.play(AssetSource(_chooseLevelSoundName), volume: .7);
    }
  }

  ///
  /// Play click home sound.
  ///
  void playClickHomeSound() {
    if (sl<SharedPreferenceHelper>().getPlaySound) {
      audioPlayer.audioCache.prefix = _assetPathSound;
      audioPlayer.seek(const Duration());
      audioPlayer.play(AssetSource(_chooseHomeSoundName), volume: .7);
    }
  }

  ///
  /// Play click game sound.
  ///
  void playClickGameSound() {
    if (sl<SharedPreferenceHelper>().getPlaySound) {
      audioPlayer.audioCache.prefix = _assetPathSound;
      audioPlayer.seek(const Duration());
      audioPlayer.play(AssetSource(_chooseGameSoundName), volume: .7);
    }
  }

  void closeBackgroundSound() {
    audioPlayerBackground.stop();
  }

  void closeSoundGame() {
    audioPlayGame.stop();
  }

  void pauseSoundGame() {
    audioPlayGame.pause();
  }

  void pauseBackgroundSound() {
    isPlayMusic.value = false;
    audioPlayerBackground.pause();
  }

  void continueBackgroundSound() {
    isPlayMusic.value = true;

    if (sl<SharedPreferenceHelper>().getPlayMusic) {
      audioPlayerBackground.resume();
    }
  }

  // Viết hàm trả về state của âm thanh
  String stateSoundBackground() {
    return audioPlayerBackground.state.toString();
  }
}
