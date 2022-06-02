import 'package:brain_cancer_detection_v1/core/util/cubit/state.dart';
import 'package:brain_cancer_detection_v1/core/util/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state) {
        if (state is UploadImageSuccess)
        {
          Fluttertoast.showToast(msg: 'Image Uploaded Successfully. You could see your result now');
          debugPrint("result is ===>>> ${result.toString()}");
        }
      },
      builder: (context, state) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveValue(
            context,
            20,
          ),
          vertical: responsiveValue(
            context,
            20,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(

            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        responsiveValue(context, 20)
                    ),
                    border: Border.all(
                        color: HexColor(regularGrey),
                        width: responsiveValue(context, 1)
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveValue(
                      context,
                      20,
                    ),
                    vertical: responsiveValue(
                      context,
                      10,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        appTranslation(context).brainCancerAnalysis,
                        style:  Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/images/brain.png',
                          width: responsiveValue(context, 80),
                          height: responsiveValue(context, 80),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              space50Vertical(context),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  AppCubit.get(context).galleryProductImage != null ?
                  Container(
                    width: responsiveValue(context, 300.0),
                    height: responsiveValue(context, 250.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(
                          AppCubit.get(context).galleryProductImage!,                        ),
                          fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(
                        responsiveValue(context, 20),
                      ),
                    ),
                  ) :
                  Container(
                    width: responsiveValue(context, 300.0),
                    height: responsiveValue(context, 250.0),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/upload_image.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(
                        responsiveValue(context, 20),
                      ),
                    ),
                  ),
                  Container(
                    width: responsiveValue(context, 55.0),
                    height: responsiveValue(context, 55.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        responsiveValue(context, 55),
                      ),
                      color: HexColor(regularGrey),
                    ),
                    child: IconButton(
                      onPressed: ()
                      {
                        AppCubit.get(context).selectImage();
                      },
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: HexColor(mainColor),
                      ),
                    ),
                  ),
                ],
              ),
              space100Vertical(context),
              MyButton(
                  onPressed: ()
                  {
                    AppCubit.get(context).galleryProductImage != null ?
                      AppCubit.get(context).uploadImage(
                        image: AppCubit.get(context).galleryProductImage!,
                      ) : Fluttertoast.showToast(msg: 'Please select an image');
                  },
                  text: appTranslation(context).confirmImage,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
