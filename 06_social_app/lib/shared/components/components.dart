import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../styles/icon_broken.dart';

TextFormField defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    enabled: isClickable,
    onFieldSubmitted: onSubmit as void Function(String)?,
    onChanged: onChange as void Function(String)?,
    onTap: onTap as void Function()?,
    validator: validate as String? Function(String?)?,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: suffixPressed as void Function()?,
              icon: Icon(
                suffix,
              ),
            )
          : null,
      border: OutlineInputBorder(),
    ),
  );
}

Container defaultButton({
  required Function onPressedFunction,
  required String text,
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
}) {
  return Container(
    width: width,
    height: 40.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
    child: MaterialButton(
      onPressed: onPressedFunction as VoidCallback,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

TextButton defaultTextButton({
  required Function onPressedFunction,
  required String text,
}) {
  return TextButton(
    onPressed: onPressedFunction as VoidCallback,
    child: Text(
      text.toUpperCase(),
    ),
  );
}

enum ToastStates {
  SUCCESS,
  WARNING,
  ERROR,
}

Color chooseToastColor({
  required ToastStates state,
}) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }

  return color;
}

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state: state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

AppBar defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) {
  return AppBar(
    titleSpacing: 0.0,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(IconBroken.Arrow___Left_2),
    ),
    title: Text(title != null ? title : ''),
    actions: actions != null ? actions : [],
  );
}



// Padding buildListProduct(
//   model,
//   context, {
//   bool isOldPrice = true,
// }) {
//   return Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Container(
//       color: MyMainColors.myWhite,
//       height: 120.0,
//       child: Row(
//         children: [
//           Stack(
//             alignment: AlignmentDirectional.bottomStart,
//             children: [
//               Image(
//                 image: NetworkImage(model.image),
//                 width: 120,
//                 height: 120,
//               ),
//               if (model.discount != 0 && isOldPrice)
//                 Container(
//                   color: MyMainColors.myRed,
//                   padding: EdgeInsets.symmetric(horizontal: 5),
//                   child: Text(
//                     'Discount ${_calculateDiscount(model)}%',
//                     style: TextStyle(
//                       fontSize: 8,
//                       color: MyMainColors.myWhite,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           const SizedBox(width: 20.0),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   model.name,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 14, height: 1.3),
//                 ),
//                 Spacer(),
//                 Row(
//                   children: [
//                     Text(
//                       '${model.price.round()}',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 14,
//                         height: 1.3,
//                         color: MyMainColors.myBlue,
//                       ),
//                     ),
//                     const SizedBox(width: 5),
//                     if (model.discount != 0 && isOldPrice)
//                       Text(
//                         '${model.oldPrice.round()}',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 10,
//                           height: 1.3,
//                           color: MyMainColors.myGrey,
//                           decoration: TextDecoration.lineThrough,
//                         ),
//                       ),
//                     Spacer(),
//                     IconButton(
//                       onPressed: () {
//                         ShopCubit.get(context).changeFavorites(model.id);
//                       },
//                       icon: CircleAvatar(
//                         radius: 15.0,
//                         backgroundColor: (ShopCubit.get(context)
//                                     .favorites[model.id]! &&
//                                 ShopCubit.get(context).favorites[model.id] ==
//                                     true)
//                             ? MyMainColors.myBlue
//                             : MyMainColors.myGrey,
//                         child: Icon(
//                           Icons.favorite_border,
//                           size: 14.0,
//                           color: MyMainColors.myWhite,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// _calculateDiscount(model) {
//   dynamic cal = ((model.oldPrice.round() - model.price.round()) /
//           model.oldPrice.round()) *
//       100;
//   return cal.floor();
// }
