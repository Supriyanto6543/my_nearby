import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_restaurant/common/common_shared.dart';
import 'package:my_restaurant/common/routes.dart';
import 'package:my_restaurant/features/domain/entities/result_entity.dart';
import 'package:my_restaurant/features/presentation/account/bloc/account_place_cubit.dart';
import 'package:my_restaurant/features/presentation/account/pages/add_place_page.dart';
import 'package:my_restaurant/features/presentation/detail/pages/detail_page.dart';
import 'package:my_restaurant/features/presentation/home/bloc/home_cubit.dart';
import 'package:my_restaurant/features/presentation/home/bloc_state/home_bloc.dart';
import 'package:my_restaurant/features/presentation/map_detail/bloc/map_cubit.dart';
import 'package:my_restaurant/features/presentation/map_detail/bloc_state/map_bloc.dart';
import 'package:my_restaurant/features/presentation/map_detail/pages/map_detail_page.dart';
import 'package:my_restaurant/features/presentation/navigation/pages/bottom_bar.dart';
import 'package:my_restaurant/features/presentation/offline/bloc/offline_cubit.dart';
import 'package:my_restaurant/features/presentation/offline/bloc_state/offline_bloc.dart';
import 'package:my_restaurant/features/presentation/search/bloc/search_cubit.dart';
import 'package:my_restaurant/features/presentation/search/pages/search_page.dart';
import 'package:my_restaurant/features/presentation/splash/bloc/splash_cubit.dart';
import 'package:my_restaurant/features/presentation/splash/pages/splash_page.dart';
import 'package:my_restaurant/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CommonShared.init();
  di.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => SplashCubit()..checkingPermission()),
    BlocProvider(create: (_) => di.locator<HomeBloc>()),
    BlocProvider(create: (_) => di.locator<MapBloc>()),
    BlocProvider(create: (_) => OfflineBloc()),
    BlocProvider(create: (_) => di.locator<HomeCubit>()),
    BlocProvider(create: (_) => di.locator<SearchCubit>()),
    BlocProvider(create: (_) => di.locator<MapCubit>()),
    BlocProvider(create: (_) => di.locator<AccountPlaceCubit>()),
    BlocProvider(create: (_) => di.locator<OfflineCubit>())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return MaterialApp(
            title: 'My Nearby',
            home: const SplashPage(),
            initialRoute: '/',
            onGenerateRoute: (setting) {
              switch (setting.name) {
                case Routes.homePage:
                  return pageRoute(BottomBar());
                case Routes.detailView:
                  final data = setting.arguments as ResultEntity;
                  return pageRoute(DetailPage(
                    entity: data,
                  ));
                case Routes.addPlace:
                  final data = setting.arguments as LatLng;
                  return pageRoute(AddPlacePage(
                    position: data,
                  ));
                case Routes.detailMap:
                  final data = setting.arguments as Map;
                  return pageRoute(MapDetailPage(
                    dis: data['position'],
                    name: data['title'],
                  ));
                case Routes.search:
                  final data = setting.arguments as String;
                  return pageRoute(SearchPage(
                    type: data,
                  ));
                default:
                  return MaterialPageRoute(
                      builder: (context) => Container(
                            color: Colors.white,
                            child: const Text('Page not found'),
                          ));
              }
            });
      },
    );
  }

  pageRoute(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
