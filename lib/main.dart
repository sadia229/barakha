import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'infrastructure/navigation/bindings/domains/domain_di_container.dart';
import 'infrastructure/navigation/config/app_router.dart';
import 'infrastructure/theme/app.theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://iebaqqdmkuebwyfyqujb.supabase.co',
    anonKey: 'sb_publishable_7n0zxrokS2LMedc6rw_6EQ_bUn82CwR',
  );
  await DomainLayerDependencyInjectionContainer.init();
  //var initialRoute = await Routes.initialRoute;
  //runApp(Main(initialRoute));
  runApp(
    const ProviderScope(
      child: Main(),
    ),
  );
}

class Main extends ConsumerWidget {
  //final String initialRoute;
  // Main(this.initialRoute);
  const Main({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      //initialRoute: initialRoute,
      //getPages: Nav.routes,
    );
  }
}
