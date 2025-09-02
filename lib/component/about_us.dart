import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(String url) async {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              "📖 About My Friend",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
                "Welcome to My Friend, your space to capture memories, express yourself, and stay connected."),
            SizedBox(height: 19),
            Text("✨ Features:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 9),
            Text("• Write your personal diary"),
            Text("• Add images & create AI-generated images"),
            SizedBox(height: 19),
            Text(
              "🐦‍🔥 Upcoming:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 9),
            Text("• Random Chat with new people"),
            Text("• Connect with friends"),
            Text("• Smart Chatbot for fun & support"),
            SizedBox(height: 23),
            Center(
              child: Text(
                "Built with ❤️ to help you write, connect & explore.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaButton.linkedin(
                  size: 18,
                  color: Colors.blue,
                  onTap: () => _launchUrl(
                      "https://www.linkedin.com/in/aditya-kumar-74gang"),
                ),
                SocialMediaButton.instagram(
                  size: 18,
                  color: Colors.red,
                  onTap: () =>
                      _launchUrl("https://www.instagram.com/aditya_gangwar_74"),
                ),
                SocialMediaButton.twitter(
                  size: 18,
                  color: Colors.black12,
                  onTap: () => _launchUrl("https://x.com/Adityagangwar74"),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mail,
                  size: 18,
                ),
                Text(
                  "\tgangwaraditya13@gmail.com",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
