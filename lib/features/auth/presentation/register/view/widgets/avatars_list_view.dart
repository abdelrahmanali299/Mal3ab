import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mal3ab/features/auth/presentation/register/manager/cubit/register_cubit.dart';

class AvatarItem extends StatelessWidget {
  const AvatarItem({super.key, required this.isActive, required this.image});
  final bool isActive;
  final Image image;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? CircleAvatar(
            radius: 38,
            backgroundColor: Colors.white,
            child: CircleAvatar(radius: 34, backgroundImage: image.image),
          )
        : CircleAvatar(radius: 38, backgroundImage: image.image);
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
    Image.asset('assets/images/3551911.jpg'),
    Image.asset('assets/images/3551911.jpg'),
    Image.asset('assets/images/3551911.jpg'),
    Image.asset('assets/images/3551911.jpg'),
    Image.asset('assets/images/3551911.jpg'),
    Image.asset('assets/images/3551911.jpg'),
    Image.asset('assets/images/3551911.jpg'),
    Image.asset('assets/images/3551911.jpg'),
    Image.asset('assets/images/3551911.jpg'),
    Image.asset('assets/images/3551911.jpg'),
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
                BlocProvider.of<RegisterCubit>(context).image = avatars[index];
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
