import 'package:durwyn_talley/src/core/utils/app_exports.dart';
import 'src/modules/authentication/domain/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // appPrint("FCM Token: $fcmToken");
  await dotenv.load(fileName: ".env").then((value) async {
    setupLocator();
    final authRepo = locator<AuthRepository>();
    final cachedToken = await authRepo.getCachedToken();
    if (cachedToken != null && cachedToken.isNotEmpty) {
      AppRouterGo.initialRoute = dashboardView;
    }
    await locator<NotificationService>().requestPermission();
    await locator<NotificationService>().init();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((value) {
      runApp(ProviderScope(child: DurwynTalley()));
    });
  });
}

class DurwynTalley extends ConsumerWidget with AppSize, AppTheme {
  const DurwynTalley({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: MediaQuery.sizeOf(context).width < 600.0
          ? const Size(440, 956)
          : Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final appThemeController = ref.watch(appThemeControllerProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouterGo.appRouter,
          title: AppStrings.durwynTalley,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: appThemeController.themeMode,
          // themeMode: ThemeMode.light,
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.noScaling);
            return MediaQuery(
              data: mediaQueryData,
              child: SafeArea(
                top: false,
                left: false,
                right: false,
                bottom: Platform.isAndroid ? true : false,
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}
