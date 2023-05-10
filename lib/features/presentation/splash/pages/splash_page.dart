import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_restaurant/common/app_permission_enum.dart';
import 'package:my_restaurant/common/custom_snackbar.dart';
import 'package:my_restaurant/common/routes.dart';
import 'package:my_restaurant/extension/sizebox_extension.dart';
import 'package:my_restaurant/features/presentation/navigation/pages/bottom_bar.dart';
import 'package:my_restaurant/features/presentation/splash/bloc/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(listenWhen: (_, state) {
      if (state is SplashLoaded) {
        return state.appPermissionEnum == AppPermissionEnum.approved;
      } else {
        return false;
      }
    }, listener: (_, state) {
      if (state is SplashLoaded) {
        Future.delayed(Duration(seconds: 3)).then((value) {
          Navigator.pushNamed(context, Routes.homePage);
        });
      } else {
        CustomSnackBar.displaySnackBar(
            _, SnackMode.error, 'Location access not granted');
      }
    }, builder: (_, state) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state is SplashInitial) ...[
              Center(
                child: SizedBox(
                    height: 50.sp,
                    width: 50.sp,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                    )),
              ),
              10.toSizedBox(h: 10),
            ],
            if (state is SplashError)
              Center(
                child: Column(
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    20.toSizedBox(h: 20),
                    InkWell(
                      onTap: () {
                        context.read<SplashCubit>().checkingPermission();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4.sp)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.sp, vertical: 10.sp),
                        child: Text(
                          'Try again',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    if (state.appPermissionEnum ==
                        AppPermissionEnum.offline) ...[
                      20.toSizedBox(h: 20),
                      Text('Or you can '),
                      20.toSizedBox(h: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.homePage);
                          BottomBar.listen.value = 3;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(4.sp)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.sp, vertical: 10.sp),
                          child: Text(
                            'Access local data',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              )
            else if (state is SplashLoaded)
              Center(
                child: Text(
                  'Access granted!  \n  Your location is: ${state.address}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                ),
              )
            else
              Center(
                child: Text(
                  'Waiting granted location !!!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                ),
              )
          ],
        ),
      );
    });
  }
}
