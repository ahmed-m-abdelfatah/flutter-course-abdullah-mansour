import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../../layout/cubit/social_cubit.dart';
import '../../models/post_model.dart';
import '../../shared/_adaptive/adaptive_circular_progress_indicator.dart';
import '../../shared/_adaptive/operating_system.dart';
import '../../shared/styles/icon_broken.dart';
import '../../shared/styles/my_main_styles.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              SocialCubit.get(context).posts.length > 0 &&
              SocialCubit.get(context).currentUser != null,
          widgetBuilder: (context) => _buildFeedsScreen(
            context,
            SocialCubit.get(context).posts,
          ),
          fallbackBuilder: (context) => Center(
            child: AdaptiveCircularProgressIndicator(
              os: OperatingSystem.getOs(),
            ),
          ),
        );
      },
    );
  }

  SingleChildScrollView _buildFeedsScreen(
    BuildContext context,
    List<PostModel> postModel,
  ) {
    return SingleChildScrollView(
      key: PageStorageKey('_buildFeedsScreen'),
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 3.0,
            margin: EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(
                  image: NetworkImage(
                    'http://unsplash.it/500/500?random&gravity=center',
                  ),
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ' comunicate With Friends ',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: MyMainColors.myWhite,
                          backgroundColor: MyMainColors.myBlack,
                        ),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            // cuz iam in SingleChildScrollView
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: postModel.length,
            itemBuilder: (context, index) => _buildPostItem(
              context: context,
              postModel: postModel[index],
              index: index,
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
          const SizedBox(height: 8.0)
        ],
      ),
    );
  }

  Card _buildPostItem({
    required BuildContext context,
    required PostModel postModel,
    required int index,
  }) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    postModel.image,
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            postModel.name,
                            style: TextStyle(height: 1.4),
                          ),
                          const SizedBox(width: 5.0),
                          if (postModel.uId == 'vzSiYSEc7FMWDfIBSwDN8O4g3Qm2')
                            Icon(
                              Icons.check_circle,
                              color: MyMainColors.myBlue,
                              size: 16.0,
                            )
                        ],
                      ),
                      Text(
                        postModel.dateTime,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15.0),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    size: 16.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
            ),
            Text(
              postModel.text,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6.0),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6.0),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            '#flutter',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (postModel.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        postModel.postImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 18.0,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              '${SocialCubit.get(context).postsLikes[index]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 18.0,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              '0 comment',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                            SocialCubit.get(context).currentUser!.image,
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        Text(
                          'write a comment ...',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context).likePost(
                      SocialCubit.get(context).postsId[index],
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 18.0,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        'Like',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
