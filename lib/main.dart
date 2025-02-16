import 'package:easy_bill_clean_architecture/features/data/clients/data_source/client_local_data_source.dart';
import 'package:easy_bill_clean_architecture/features/data/clients/repository/client_repository_impl.dart';
import 'package:easy_bill_clean_architecture/features/domain/clients/use_cases/add_client_use_case.dart';
import 'package:easy_bill_clean_architecture/features/domain/clients/use_cases/get_clients_use_case.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/rounter/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // make the multi provider available through the app
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClientBloc(
            getClientsUseCase: GetClientsUseCase(
              ClientRepositoryImpl(
                ClientLocalDataSource(),
              ),
            ),
            addClientUseCase: AddClientUseCase(
              ClientRepositoryImpl(
                ClientLocalDataSource(),
              ),
            ),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
  // only portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // remove debug badge
      debugShowCheckedModeBanner: false,
      // load the theme / dark or light from the app settings
      // theme: context.watch<SettingsProvider>().isDarMode
      //     ? ThemeData.dark()
      //     : ThemeData.light(),
      routerConfig: appRouter,
      // locale: context.read<SettingsProvider>().currentLocal,
    );
  }
}
