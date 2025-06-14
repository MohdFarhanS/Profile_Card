import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/custom_column.dart';
import '../widgets/circle_avatar_widget.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/social_media_row.dart';
import '../widgets/styled_container.dart';
import '../utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  UserModel get _sampleUser => UserModel(
    name: "Mohd. Farhan. S",
    description:
        "Flutter Developer | Web Developer\n"
        "Passionate about creating beautiful and functional mobile and web applications. "
        "Always learning new technologies and sharing knowledge with the community.",
    profileImage: "assets/images/foto.jpg",
    socialMediaList: [
      SocialMedia(
        platform: "Instagram",
        url: "https://www.instagram.com/mhd__farhan_/",
        iconPath: "assets/icons/instagram_logo.jpg",
        color: const Color(0xFFE4405F),
      ),
      SocialMedia(
        platform: "LinkedIn",
        url: "https://www.linkedin.com/in/mohd-farhan-s/",
        iconPath: "assets/icons/linkedin_logo.png",
        color: const Color(0xFF0A66C2),
      ),
      SocialMedia(
        platform: "GitHub",
        url: "https://github.com/MohdFarhanS",
        iconPath: "assets/icons/github_logo.png",
        color: const Color(0xFF333333),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.lerp(
                    AppColors.primaryColor.withAlpha((255 * 0.1).round()),
                    AppColors.secondaryColor.withAlpha((255 * 0.1).round()),
                    _backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    AppColors.backgroundColor,
                    AppColors.accentColor.withAlpha((255 * 0.5).round()),
                    _backgroundAnimation.value,
                  )!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      // Profile Card
                      StyledContainer(
                        hasHoverEffect: true,
                        padding: const EdgeInsets.all(30),
                        child: CustomColumn(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Profile Avatar
                            CircleAvatarWidget(
                              imageUrl: _sampleUser.profileImage,
                              radius: 70,
                              showBorder: true,
                              borderColor: AppColors.primaryColor,
                              borderWidth: 4,
                            ),

                            const SizedBox(height: 20),

                            // Name
                            CustomTextWidget(
                              text: _sampleUser.name,
                              textType: TextType.heading,
                              isGradient: true,
                            ),

                            const SizedBox(height: 15),

                            // Description
                            CustomTextWidget(
                              text: _sampleUser.description,
                              textType: TextType.body,
                              textAlign: TextAlign.center,
                              maxLines: 5,
                            ),

                            const SizedBox(height: 30),

                            // Social Media Icons
                            SocialMediaRow(
                              socialMediaList: _sampleUser.socialMediaList,
                              iconSize: 40,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Stats Cards Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              "Projects",
                              "5+",
                              Icons.code,
                              AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _buildStatCard(
                              "Experience",
                              "<1 Years",
                              Icons.work,
                              AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Skills Section
                      StyledContainer(
                        hasHoverEffect: true,
                        child: CustomColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextWidget(
                              text: "Skills & Technologies",
                              textType: TextType.subheading,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 20),
                            _buildSkillsRow([
                              "Flutter",
                              "Dart",
                              "HTML",
                              "CSS",
                              "JavaScript",
                              "React Native",
                              "Git",
                            ]),
                            const SizedBox(height: 10),
                            _buildSkillsRow(["Visual Studio Code"]),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),
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

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return StyledContainer(
      hasHoverEffect: true,
      padding: const EdgeInsets.all(20),
      gradient: LinearGradient(
        colors: [
          color.withAlpha((255 * 0.1).round()),
          color.withAlpha((255 * 0.5).round()),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: CustomColumn(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha((255 * 0.1).round()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          CustomTextWidget(
            text: value,
            textType: TextType.subheading,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          CustomTextWidget(
            text: title,
            textType: TextType.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsRow(List<String> skills) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: skills.map((skill) => _buildSkillChip(skill)).toList(),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withAlpha((255 * 0.2).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CustomTextWidget(
        text: skill,
        textType: TextType.caption,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        isAnimated: false,
      ),
    );
  }
}
