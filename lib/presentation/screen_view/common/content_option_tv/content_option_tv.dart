import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wise_players/core/colors/colors.dart';
import 'package:wise_players/presentation/screen_view/common/movies/movies_screen.dart';

class ContentOption extends StatefulWidget {
  const ContentOption({super.key});

  @override
  State<ContentOption> createState() => _ContentOptionState();
}

class _ContentOptionState extends State<ContentOption> {
  final FocusNode _refreshFocusNode = FocusNode();
  int _selectedMainMenuItem = 0;

  @override
  void dispose() {
    _refreshFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTV = size.width > 800;
    final isMobile = size.width < 600;

    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            _handleRemoteControl(event);
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTV ? 1200 : double.infinity,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTV ? 60.0 : (isMobile ? 16.0 : 24.0),
                    vertical: isTV ? 40.0 : 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Header Section
                      _buildHeader(
                        isTV,
                        isMobile,
                        "Perfect Mix of Toxicity",
                        "20/02/2026 17:28",
                      ),

                      SizedBox(height: isTV ? 50 : (isMobile ? 30 : 35)),

                      // Main Menu Grid
                      _buildMainMenuGrid(isTV, isMobile),

                      SizedBox(height: isTV ? 40 : (isMobile ? 25 : 30)),

                      // Action Buttons
                      _buildActionButtonsRow(isTV, isMobile),

                      SizedBox(height: isTV ? 35 : (isMobile ? 20 : 25)),

                      // MAC Address
                      _buildMACAddress(isTV, isMobile, '00:1A:BO:FC:AA:SO'),

                      SizedBox(height: 12),

                      // Footer Message
                      _buildFooter(isTV, isMobile),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isTV, bool isMobile, playlistName, expiresDate) {
    return Column(
      children: [
        Image.asset('assets/images/Wise Player.png'),

        SizedBox(height: isTV ? 28 : (isMobile ? 18 : 22)),

        // Current Playlist
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current playlist: ',
              style: TextStyle(
                fontSize: isTV ? 20 : (isMobile ? 14 : 16),
                color: Colors.white70,
              ),
            ),
            Text(
              '$playlistName',
              style: TextStyle(
                fontSize: isTV ? 20 : (isMobile ? 14 : 16),
                color: AppColor.golden,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        SizedBox(height: isTV ? 15 : 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.tag_faces,
              color: AppColor.softYellow,
              size: isTV ? 16 : (isMobile ? 12 : 14),
            ),
            SizedBox(width: 8),
            Text(
              'Active ',
              style: TextStyle(
                fontSize: isTV ? 17 : (isMobile ? 13 : 15),
                color: AppColor.white,
                fontWeight: FontWeight.w500,
              ),
            ),

            Icon(
              Icons.timer_outlined,
              color: AppColor.softYellow,
              size: isTV ? 16 : (isMobile ? 12 : 14),
            ),

            Text(
              ' Expires on $expiresDate',
              style: TextStyle(
                fontSize: isTV ? 17 : (isMobile ? 13 : 15),
                color: AppColor.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainMenuGrid(bool isTV, bool isMobile) {
    final menuItems = [
      _MenuItemModel(
        image: 'assets/icons/live-tv.png',
        label: 'Live TV',
        onTap: () => _navigateTo('Live TV'),
      ),
      _MenuItemModel(
        image: "assets/icons/movies.png",
        label: 'Movies',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MoviesScreen()),
        ),
      ),
      _MenuItemModel(
        image: 'assets/icons/series.png',
        label: 'Series',
        onTap: () => _navigateTo('Series'),
      ),
      _MenuItemModel(
        image: 'assets/icons/radio.png',
        label: 'Radios',
        onTap: () => _navigateTo('Radios'),
      ),
    ];

    double cardWidth = isTV ? 200 : (isMobile ? 150 : 170);
    double cardHeight = isTV ? 180 : (isMobile ? 140 : 160);

    return Wrap(
      spacing: isTV ? 24 : (isMobile ? 14 : 18),
      runSpacing: isTV ? 24 : (isMobile ? 14 : 18),
      alignment: WrapAlignment.center,
      children: List.generate(menuItems.length, (index) {
        return _buildMainMenuCard(
          item: menuItems[index],
          index: index,
          isTV: isTV,
          isMobile: isMobile,
          width: cardWidth,
          height: cardHeight,
        );
      }),
    );
  }

  Widget _buildMainMenuCard({
    required _MenuItemModel item,
    required int index,
    required bool isTV,
    required bool isMobile,
    required double width,
    required double height,
  }) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          setState(() {
            _selectedMainMenuItem = index;
          });
        }
      },
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: item.onTap,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColor.darkBlue.withAlpha(60),
                    AppColor.darkBlue.withAlpha(60),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColor.white),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: item.onTap,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      AnimatedScale(
                        scale: 1.1,
                        duration: Duration(milliseconds: 200),
                        // child: Icon(
                        //   item.icon,
                        //   size: isTV ? 70 : (isMobile ? 50 : 60),
                        //   color: Colors.white,
                        // ),
                        child: Image.asset(
                          item.image,
                          color: AppColor.white,
                          height: isTV ? 70 : (isMobile ? 50 : 60),
                          width: isTV ? 70 : (isMobile ? 50 : 60),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          item.label,
                          style: TextStyle(
                            fontSize: isTV ? 15 : (isMobile ? 15 : 17),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: isTV ? 14 : 10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButtonsRow(bool isTV, bool isMobile) {
    return Wrap(
      spacing: isTV ? 14 : (isMobile ? 8 : 10),
      runSpacing: isTV ? 14 : (isMobile ? 8 : 10),
      alignment: WrapAlignment.center,
      children: [
        _buildActionButton(
          'Refresh',
          isTV,
          isMobile,
          focusNode: _refreshFocusNode,
        ),
        _buildActionButton('Change Playlist', isTV, isMobile),
        _buildActionButton('Language (EN)', isTV, isMobile),
        _buildActionButton('Time Shift', isTV, isMobile),
        _buildIconButton(Icons.settings_rounded, 'Settings', isTV, isMobile),
        _buildIconButton(Icons.info_outline_rounded, 'Info', isTV, isMobile),
        _buildIconButton(
          Icons.power_settings_new_rounded,
          'Exit',
          isTV,
          isMobile,
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    bool isTV,
    bool isMobile, {
    FocusNode? focusNode,
  }) {
    return Focus(
      focusNode: focusNode,
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;

          return GestureDetector(
            onTap: () => _handleActionButton(label),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              padding: EdgeInsets.symmetric(
                horizontal: isTV ? 20 : (isMobile ? 14 : 16),
                vertical: isTV ? 12 : (isMobile ? 9 : 10),
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withAlpha(90),
                borderRadius: BorderRadius.circular(8),
                border: isFocused
                    ? Border.all(color: Colors.white, width: 2.5)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: isFocused ? 8 : 4,
                    offset: Offset(0, isFocused ? 4 : 2),
                  ),
                ],
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isTV ? 16 : (isMobile ? 12 : 14),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconButton(
    IconData icon,
    String tooltip,
    bool isTV,
    bool isMobile,
  ) {
    return Focus(
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;

          return GestureDetector(
            onTap: () => _handleActionButton(tooltip),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              padding: EdgeInsets.all(isTV ? 14 : (isMobile ? 10 : 12)),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withAlpha(90),
                borderRadius: BorderRadius.circular(8),
                border: isFocused
                    ? Border.all(color: Colors.white, width: 2.5)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: isFocused ? 8 : 4,
                    offset: Offset(0, isFocused ? 4 : 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: isTV ? 24 : (isMobile ? 18 : 20),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMACAddress(bool isTV, bool isMobile, macNumber) {
    return Text(
      'Your MAC: $macNumber',
      style: TextStyle(
        fontSize: isTV ? 16 : (isMobile ? 12 : 14),
        color: Colors.white60,
        letterSpacing: 1.0,
        fontFamily: 'monospace',
      ),
    );
  }

  Widget _buildFooter(bool isTV, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTV ? 40 : 20),
      child: Text(
        'WisePlayer.app is a TV player only, and does not include any channels ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isTV ? 14 : (isMobile ? 11 : 12),
          color: AppColor.darkRed,
        ),
      ),
    );
  }

  void _handleRemoteControl(RawKeyEvent event) {
    // Handle TV remote control keys
    if (event.logicalKey == LogicalKeyboardKey.select ||
        event.logicalKey == LogicalKeyboardKey.enter) {
      // Handle select/enter
      print('Select pressed');
    } else if (event.logicalKey == LogicalKeyboardKey.escape ||
        event.logicalKey == LogicalKeyboardKey.goBack) {
      // Handle back button
      Navigator.of(context).maybePop();
    }
  }

  void _navigateTo(String destination) {
    print('Navigating to: $destination');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $destination...'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF27AE60),
      ),
    );
  }

  void _handleActionButton(String action) {
    print('Action: $action');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action clicked'),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF3498DB),
      ),
    );
  }
}

class _MenuItemModel {
  final String image;
  final String label;
  final VoidCallback onTap;

  _MenuItemModel({
    required this.image,
    required this.label,
    required this.onTap,
  });
}
