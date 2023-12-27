import 'package:flutter/material.dart';

class PerfilChoiceWidget extends StatelessWidget {
  final int currentProfile;
  final Function(int) onProfileSelected;

  const PerfilChoiceWidget({Key? key, required this.currentProfile, required this.onProfileSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () => onProfileSelected(1),
          child: _buildProfileWidget(1, "Jota"),
        ),
        InkWell(
          onTap: () => onProfileSelected(2),
          child: _buildProfileWidget(2, "Ambos"),
        ),
        InkWell(
          onTap: () => onProfileSelected(3),
          child: _buildProfileWidget(3, "Déborah"),
        ),
      ],
    );
  }

  Widget _buildProfileWidget(int profileNumber, String profileName) {
    bool isSelected = currentProfile == profileNumber;

    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.green : Colors.transparent,
            ),
            shape: BoxShape.circle,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            // child: Image,
          ),
        ),
        if (isSelected)
          Positioned(
            top: 75,
            child: Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(profileName),
            ),
          ),
      ],
    );
  }
}
