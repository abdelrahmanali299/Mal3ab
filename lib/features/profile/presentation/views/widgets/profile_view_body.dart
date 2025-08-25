import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          SizedBox(height: size.height * .08),
          Image.asset('assets/images/3551911.jpg', width: size.width * .4),
          Text(
            'moaz waleed',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            'registerd player',
            style: TextStyle(
              color: Colors.black.withValues(alpha: .5),
              fontSize: 16,
            ),
          ),
          SizedBox(height: size.height * .03),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Actions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(height: size.height * .01),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(FontAwesomeIcons.xmark),
                ),
                SizedBox(width: size.width * .05),
                Text('Withdrow From Match', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          SizedBox(height: size.height * .02),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    FontAwesomeIcons.userGroup,
                    size: size.width * .04,
                  ),
                ),
                SizedBox(width: size.width * .05),
                Text('View Registerd Players', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
