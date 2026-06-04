import 'package:flutter/material.dart';

import '../../../utils/common_color.dart';
import '../../../utils/common_font_style.dart';
import '../../bloc/profile_bloc.dart';
import 'profile_body.dart';
import 'profile_side_menu.dart';

class ProfileScaffold extends StatefulWidget {
  const ProfileScaffold({
    super.key,
    required this.state,
  });

  final ProfileState state;

  @override
  State<ProfileScaffold> createState() => _ProfileScaffoldState();
}

class _ProfileScaffoldState extends State<ProfileScaffold> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  void _closeMenu() {
    if (_isMenuOpen) {
      setState(() => _isMenuOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColor.appBarColor(),
        leading: IconButton(
          icon: Icon(
            _isMenuOpen ? Icons.close : Icons.menu,
            color: Colors.white,
          ),
          onPressed: _toggleMenu,
        ),
        title: Text(
          'Profile',
          style: CommonFontStyle.boldFontStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ProfileBody(state: widget.state),
          if (_isMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeMenu,
                child: Container(color: Colors.black.withOpacity(0.25)),
              ),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            top: 0,
            bottom: 0,
            left: _isMenuOpen ? 0 : -260,
            child: ProfileSideMenu(
              onClose: _closeMenu,
            ),
          ),
        ],
      ),
    );
  }
}