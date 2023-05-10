import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_restaurant/common/custom_snackbar.dart';
import 'package:my_restaurant/common/routes.dart';
import 'package:my_restaurant/extension/list_extension.dart';
import 'package:my_restaurant/extension/sizebox_extension.dart';
import 'package:my_restaurant/features/presentation/account/bloc/account_place_cubit.dart';
import 'package:my_restaurant/injection.dart' as di;

import '../../../../common/common_shared.dart';
import '../../../../common/hex_color.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final position = CommonShared.getCurPos;
    String lat = position != null ? position[0] : '';
    String long = position != null ? position[1] : '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColorFromHex(bgColorBlack),
        automaticallyImplyLeading: false,
        title: Text(
          'Account',
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
      body: BlocProvider(
        create: (_) => di.locator<AccountPlaceCubit>()..fetchAllData(),
        child: BlocBuilder<AccountPlaceCubit, AccountPlaceState>(
          builder: (context, state) {
            return Column(
              children: [
                if (state is AccountPlaceLoaded)
                  if (state.list.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                          child: 10.toList(
                              length: state.list.length,
                              builder: (_, index) {
                                return Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 12.sp),
                                  padding: EdgeInsets.all(10.sp),
                                  child: ExpansionTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.sp),
                                        ),
                                        12.toSizedBox(w: 12),
                                        Expanded(
                                          child: Text(
                                            state.list[index].address,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18.sp),
                                          ),
                                        )
                                      ],
                                    ),
                                    childrenPadding: EdgeInsets.zero,
                                    tilePadding: EdgeInsets.zero,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var local = state.list[index];
                                          context
                                              .read<AccountPlaceCubit>()
                                              .useAddress(local)
                                              .then((value) {
                                            CustomSnackBar.displaySnackBar(
                                                _,
                                                SnackMode.success,
                                                "Success choose this place");
                                          });
                                        },
                                        child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(16.sp),
                                            margin: EdgeInsets.all(10.sp),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.sp),
                                                color: Colors.blueAccent),
                                            child: Text(
                                              'Use this address',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp),
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              })),
                    )
                  else
                    Expanded(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: Text(
                            'No local place yet',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                    )
                else if (state is AccountPlaceInitial)
                  Expanded(
                      child: Center(
                    child: SizedBox(
                        height: 30.sp,
                        width: 30.sp,
                        child: CircularProgressIndicator()),
                  ))
                else
                  Expanded(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Text(
                          'No local place yet',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    Connectivity().checkConnectivity().then((value) {
                      if (value == ConnectivityResult.none) {
                        CustomSnackBar.displaySnackBar(
                            context, SnackMode.error, "You are offline");
                      } else {
                        Navigator.pushNamed(context, Routes.addPlace,
                                arguments: LatLng(double.tryParse(lat)!,
                                    double.tryParse(long)!))
                            .then((value) {
                          context.read<AccountPlaceCubit>().fetchAllData();
                        });
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.sp),
                    margin: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.blueAccent),
                    child: Text(
                      'Add Place Position',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
