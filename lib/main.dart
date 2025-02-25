import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_state.dart';
import 'package:easy_bill_clean_architecture/injection_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'core/rounter/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  runApp(
    // make the multi provider available through the app
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ClientBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ItemBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<BusinessInfoBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<InvoiceBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SettingsBloc>()
            ..add(GetCurrencyEvent())
            ..add(GetThemeModeEvent())
            ..add(GetSignatureEvent()),
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
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        // late bool isDarkMode = false;
        // if (state is SettingsThemeModeUpdated) {
        //   isDarkMode = state.isDarkMode!;
        // }
        return MaterialApp.router(
          // remove debug badge
          debugShowCheckedModeBanner: false,
          // load the theme / dark or light from the app settings
          theme: state.isDarkMode! ? ThemeData.dark() : ThemeData.light(),
          routerConfig: appRouter,
          // locale: context.read<SettingsProvider>().currentLocal,
        );
      },
    );
  }
}

// BlocProvider(
// create: (context) => ClientBloc(
// getClientsUseCase: GetClientsUseCase(
// ClientRepositoryImpl(
// ClientLocalDataSource(),
// ),
// ),
// addClientUseCase: AddClientUseCase(
// ClientRepositoryImpl(
// ClientLocalDataSource(),
// ),
// ),
// ),
// ),
// BlocProvider(
// create: (context) => ItemBloc(
// itemUseCases: ItemUseCaseImpl(
// ItemRepositoryImpl(
// ItemLocalDataSourceImpl(),
// ),
// ),
// ),
// ),
