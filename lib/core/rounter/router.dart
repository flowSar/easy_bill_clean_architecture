import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/presentation/clients/screens/clients_screen.dart';
import '../../features/presentation/clients/screens/new_client_screen.dart';
import '../../features/presentation/invoices/screens/new_invoice_screen.dart';
import '../../features/presentation/invoices/screens/preview_invoice_screen.dart';
import '../../features/presentation/items/screens/items_screen.dart';
import '../../features/presentation/items/screens/new_item_screen.dart';
import '../../features/settings/presentation/screens/about_screen.dart';
import '../../features/settings/presentation/screens/business_screen.dart';
import '../../features/settings/presentation/screens/customer_support_screen.dart';
import '../../features/settings/presentation/screens/invoice_template_screen.dart';
import '../../features/settings/presentation/screens/signature_screen.dart';
import '../../screens/bottom_nav_bar.dart';
import '../../screens/welcome_screen.dart';
import '../constance/g_constants.dart';
import '../models/invoice.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => WelcomeScreen(),
      routes: [
        GoRoute(
            path: 'bottomNavBar',
            builder: (BuildContext context, GoRouterState state) {
              return BottomNavBar();
            }),
        GoRoute(
          path: 'newBillScreen',
          builder: (BuildContext context, GoRouterState state) {
            return NewInvoiceScreen();
          },
        ),
        GoRoute(
          path: 'newClientScreen',
          builder: (BuildContext context, GoRouterState state) {
            ClientScreenParams params = state.extra as ClientScreenParams;
            return NewClientScreen(
              client: params.client,
              mode: params.mode,
            );
          },
        ),
        GoRoute(
            path: 'itemsScreen',
            builder: (BuildContext context, GoRouterState state) {
              ItemScreenParams params = state.extra as ItemScreenParams;
              return ItemsScreen(
                mode: params.mode,
              );
            }),
        GoRoute(
          path: 'newItemScreen',
          builder: (BuildContext context, GoRouterState state) {
            // check if the item that we're gonna pass is null or not before we cast it because we can't cast null to item
            ItemScreenParams params = state.extra as ItemScreenParams;

            return NewItemScreen(
              item: params.item,
              mode: params.mode,
            );
          },
        ),
        GoRoute(
          path: 'clientScreen',
          builder: (BuildContext context, GoRouterState state) {
            ClientScreenParams params = state.extra as ClientScreenParams;
            return ClientsScreen(
              mode: params.mode,
            );
          },
        ),
        GoRoute(
          path: 'welcomeScreen',
          builder: (BuildContext context, GoRouterState state) =>
              WelcomeScreen(),
        ),
        GoRoute(
          path: 'businessScreen',
          builder: (BuildContext context, GoRouterState state) =>
              BusinessScreen(),
        ),
        GoRoute(
          path: 'previewBillScreen',
          builder: (BuildContext context, GoRouterState state) {
            GeneralInvoice? bill;
            if (state.extra != null) {
              bill = state.extra as GeneralInvoice;
            }
            return PreviewInvoiceScreen(
              invoice: bill,
            );
          },
        ),
        GoRoute(
          path: 'aboutScreen',
          builder: (BuildContext context, GoRouterState state) => AboutScreen(),
        ),
        GoRoute(
          path: 'signatureScreen',
          builder: (BuildContext context, GoRouterState state) =>
              SignatureScreen(),
        ),
        GoRoute(
          path: 'customerSupportScreen',
          builder: (BuildContext context, GoRouterState state) =>
              CustomerSupportScreen(),
        ),
        GoRoute(
          path: 'invoiceTemplateScreen',
          builder: (BuildContext context, GoRouterState state) =>
              InvoiceTemplateScreen(),
        ),
      ],
    ),
  ],
);
