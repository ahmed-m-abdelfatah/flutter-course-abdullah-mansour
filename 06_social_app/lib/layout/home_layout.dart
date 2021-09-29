import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_router.dart';
import 'cubit/social_cubit.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is NewPost) {
          Navigator.of(context).pushNamed(AppRouter.newPostScreen);
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        // UserModel? currentUser = SocialCubit.get(context).currentUser;

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.appBarTitles[cubit.currentIndex]),
            // actions: [
            //   IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
            //   IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
            // ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomNavigationBarItems(index);
            },
            items: cubit.bottomNavigationBarItems,
          ),
        );
      },
    );
  }
}


// Conditional.single(
//             context: context,
//             conditionBuilder: (BuildContext context) => currentUser != null,
//             widgetBuilder: (BuildContext context) {
//               return Column(
//                 children: [
//                   // if (!currentUser!.emailVerified)
//                   if (!FirebaseAuth.instance.currentUser!.emailVerified)
//                     Container(
//                       height: 50.0,
//                       color: Colors.amber.withOpacity(0.6),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: Row(
//                           children: [
//                             Icon(Icons.info_outline_rounded),
//                             const SizedBox(width: 10.0),
//                             Expanded(
//                               child: Text('Please verify your email'),
//                             ),
//                             const SizedBox(width: 10.0),
//                             defaultTextButton(
//                               onPressedFunction: () async {
//                                 User? user = FirebaseAuth.instance.currentUser;

//                                 if (user != null && !user.emailVerified) {
//                                   await user.sendEmailVerification().then(
//                                         (value) => showToast(
//                                           text: 'Check Your Mail',
//                                           state: ToastStates.SUCCESS,
//                                         ),
//                                       );
//                                 }
//                               },
//                               text: 'verify',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             },
//             fallbackBuilder: (BuildContext context) {
//               return Center(child: CircularProgressIndicator());
//             },
//           )
