import 'dart:async';

import 'package:road_app/cores/__cores.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<TimerState> {
  Timer? _timer;

  TimerCubit() : super(TimerState.initial());

  void start({int initialDuration = 60}) {
    emit(TimerState.countdown(initialDuration));
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      _onTick,
    );
  }

  void _onTick(Timer timer) {
    final newDuration = state.duration! - 1;
    if (newDuration > 0) {
      emit(TimerState.countdown(newDuration));
    } else {
      _timer?.cancel();
      emit(TimerState.complete());
    }
  }

  void reset() {
    _timer?.cancel();
    emit(TimerState.initial());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

// Timer States
enum TimerStatus { initial, countdown, complete }

extension TimerStatusX on TimerStatus {
  bool get isInitial => this == TimerStatus.initial;
  bool get isCountdown => this == TimerStatus.countdown;
  bool get isComplete => this == TimerStatus.complete;
}

class TimerState extends Equatable {
  final TimerStatus status;
  final int? duration;

  const TimerState(this.status, this.duration);

  factory TimerState.initial() => const TimerState(TimerStatus.initial, 0);

  factory TimerState.countdown(int duration) => TimerState(
        TimerStatus.countdown,
        duration,
      );

  factory TimerState.complete() => const TimerState(TimerStatus.complete, 0);

  bool get isComplete => status == TimerStatus.complete;

  bool get isCountdown => status == TimerStatus.countdown;

  String get counterText {
    if (status == TimerStatus.complete) return AppStrings.resend;

    if (duration! <= 60) {
      // Display only seconds
      return '$duration sec';
    } else {
      // Display minutes and seconds
      int minutes = (duration! ~/ 60);
      int seconds = (duration! % 60);
      String minutesStr = (minutes >= 10) ? '$minutes' : '0$minutes';
      String secondsStr = (seconds >= 10) ? '$seconds' : '0$seconds';
      return '$minutesStr min: $secondsStr sec';
    }
  }

  TimerState copyWith({
    TimerStatus? status,
    int? duration,
  }) {
    return TimerState(
      status ?? this.status,
      duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [
        status,
        duration,
      ];
}
