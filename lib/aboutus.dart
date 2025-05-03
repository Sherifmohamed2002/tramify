import 'package:flutter/material.dart';
import 'package:app/widgets/info_card.dart';
import 'package:app/widgets/team_member_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 640;
    final horizontalPadding = isSmallScreen ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F9FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    // Header Section
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48.0),
                      child: Column(
                        children: [
                          Text(
                            'About Tramify',
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(fontSize: isSmallScreen ? 32 : 48),
                            textAlign: TextAlign.center,
                            semanticsLabel: 'About Tramify',
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Welcome to Tramify! We help you move smarter through Alexandria by showing you the live locations of trams and buses in real-time.',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontSize: isSmallScreen ? 18 : 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // Mission Section
                    const InfoCard(
                      title: 'Our Mission',
                      content:
                          'Our mission is simple: to make public transportation in Alexandria faster, easier, and more predictable for everyone.',
                    ),
                    const SizedBox(height: 48),

                    // Story Section
                    InfoCard(
                      title: '📖 Our Story',
                      content: [
                        'Tramify was born out of real-life frustration. Waiting at tram and bus stations for unknown amounts of time — without knowing if a vehicle is even coming — wastes precious minutes and creates daily stress.',
                        'That\'s why we created Tramify: a way to stay informed, plan ahead, and never feel lost at a station again.',
                      ].join('\n\n'),
                    ),
                    const SizedBox(height: 48),

                    // Team Section
                    InfoCard(
                      title: '👨‍💻 Our Team',
                      content: '',
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isSmallScreen ? 2 : 3,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          final teamMembers = [
                            'Seif Hany',
                            'Sherif Mohamed',
                            'Ziad Khamis',
                            'Ziad Ihab',
                            'Nagham',
                            'Hagar',
                          ];
                          return TeamMemberCard(name: teamMembers[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Contact Section
                    const InfoCard(
                      title: '📬 Contact Us',
                      content:
                          'Have feedback, questions, or just want to say hello?',
                      footer: 'Reach out to us at: your_email@example.com',
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
