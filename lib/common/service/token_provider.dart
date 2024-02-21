import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TokenState {
  present,
  absent,
}

final tokenProvider = StateProvider((ref) => TokenState.absent);
