import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/core/cache/shared_preferences_cache.dart';
import 'package:flutter_application_1/core/funcation/upload_image_prof.dart';
import 'package:flutter_application_1/core/network/api_consumer.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_image_state.dart';

class AddImageCubit extends Cubit<AddImageState> {
  final ApiConsumer api;
  AddImageCubit(this.api) : super(AddImageInitial());

  XFile? profilepic;




void getSavedProfileImage() {
  final path = SharedPreferencesCache.getdata(
    key: "profile_image",
  );

  if (path != null) {
    profilepic = XFile(path);
    emit(AddImageUploadSelected());
  }
}









  // ✅ فقط بتخزن الصورة وتعمل emit عشان الـ UI يتحدث
  void uploadprofilepic(XFile image)async {
    profilepic = image;
    emit(AddImageUploadSelected());
      await SharedPreferencesCache.setdata(
    key: "profile_image",
    value: image.path,
  );
  }

  // ✅ الرفع للسيرفر
  Future<void> addimage() async {
    if (profilepic == null) return; // guard

    try {
      emit(AddImageLoading());

      await api.post(
        ApiEndpoints.addimageprofile,
        isformdata: true,
        data: {
          // ✅ الإصلاح الرئيسي: كنت بتعمل cast للـ method بدل الـ variable
          Apikey.profilepic: await uploadprofiltoapi(profilepic!),
        },
      );

      emit(AddImageSuccess());
    } catch (e) {
      emit(AddImageError(error: e.toString()));
    }
  }
}