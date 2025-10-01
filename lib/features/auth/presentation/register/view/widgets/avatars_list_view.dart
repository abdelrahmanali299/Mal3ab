import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal3ab/features/auth/data/model/user_model.dart';
import 'package:mal3ab/features/auth/presentation/register/manager/cubit/register_cubit.dart';

class AvatarItem extends StatelessWidget {
  const AvatarItem({super.key, required this.isActive, required this.image});
  final bool isActive;
  final Image image;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: isActive ? Colors.green : Colors.white,
      child: FittedBox(child: image),
    );
  }
}

class AvatarsListView extends StatefulWidget {
  const AvatarsListView({super.key});
  @override
  State<AvatarsListView> createState() => _AvatarsListViewState();
}

class _AvatarsListViewState extends State<AvatarsListView> {
  int currentIndex = 0;
  List<Image> avatars = [
    Image.asset('assets/images/Arnold_image-removebg-preview.png'),
    Image.asset('assets/images/Hakimi_image-removebg-preview.png'),
    Image.asset('assets/images/Kylian_image-removebg-preview.png'),
    Image.asset('assets/images/messi_image-removebg-preview.png'),
    Image.asset('assets/images/neymar_image-removebg-preview.png'),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .1,
      child: ListView.builder(
        itemCount: avatars.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () {
                currentIndex = index;
                AssetImage image = avatars[index].image as AssetImage;
                String imageName = image.assetName;
                BlocProvider.of<RegisterCubit>(context).image = imageName;
                setState(() {});
              },
              child: AvatarItem(
                isActive: currentIndex == index,
                image: avatars[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
