import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/core/interfaces/repository/sura/sura.repository.dart';

final suraProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = ref.watch(suraRepositoryProvider);
  return repo.fetchSura();
});
