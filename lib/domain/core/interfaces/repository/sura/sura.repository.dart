import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../handler/superbase_provider.dart';

class SuraRepository {
  final SupabaseClient client;

  SuraRepository(this.client);

  Future<List<Map<String, dynamic>>> fetchSura() async {
    final data =
        await client.from('sura').select().order('id', ascending: true);
    debugPrint("Sura data from Supabase: $data");
    return List<Map<String, dynamic>>.from(data);
  }
}

final suraRepositoryProvider = Provider<SuraRepository>((ref) {
  final client = ref.watch(superbaseClientProvider);
  return SuraRepository(client);
});
