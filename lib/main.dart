import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weeding_invitation/Presentation/Screens/invitation_home.dart';
import 'package:weeding_invitation/Presentation/Screens/couple_login.dart';
import 'package:weeding_invitation/Presentation/Screens/couple_dashboard.dart';
import 'package:weeding_invitation/Core/Navigation/navigation_service.dart';
import 'package:weeding_invitation/firebase_options.dart';
import 'package:weeding_invitation/Logic/Cubit/invitation_cubit.dart';
import 'package:weeding_invitation/Logic/Cubit/couples_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => InvitationCubit()),
        BlocProvider(create: (_) => CouplesCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(1440, 1024),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Our Wedding Invitation',
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            locale: const Locale('ar', ''),
            supportedLocales: const [Locale('ar', ''), Locale('en', '')],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: AppRoutes.home,
            routes: {
              AppRoutes.home: (_) => InvitationHome(),
              AppRoutes.login: (_) => CoupleLogin(),
              AppRoutes.dashboard: (_) => CoupleDashboard(),
            },
          );
        },
      ),
    );
  }
}
