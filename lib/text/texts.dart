import 'package:flutter/material.dart';
import 'package:sv_video_app/themes/app_colors.dart';
import 'package:sv_video_app/themes/custome_widgets.dart';

class AppText {
  static final termsAndConditons = RichText(
    text: TextSpan(style: CustomeTextStyle.defultText, children: [
      TextSpan(
          text: 'TERMS AND CONDITIONS\n'.toUpperCase(),
          style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nWelcome to our video player app! These Terms and Conditions ("Agreement") govern your use of our video player app ("SV player") and any services offered within the App. By accessing or using our App, you agree to be bound by this Agreement.\n'),
      const TextSpan(
          text: '\n1. Use of the App', style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nYou agree to use the App only for its intended purpose of playing videos. You must not use the App for any illegal or unauthorized purpose, and you are solely responsible for complying with all applicable laws and regulations in your jurisdiction.\n'),
      const TextSpan(
          text: '\n2. Intellectual Property',
          style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nAll content, including videos, images, and text, displayed in the App are the property of the App owner or licensed to the App owner. You must not copy, modify, distribute, or use any of the content without permission.\n'),
      const TextSpan(
          text: '\n3. User-generated Content',
          style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nIf the App allows users to upload and share their own videos or comments, you agree that you are solely responsible for the content you upload, and the App owner is not responsible for any infringement of intellectual property rights or any damages caused by user-generated content.\n'),
      const TextSpan(
          text: '\n4. Age Restrictions', style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nThe App may contain explicit content, and therefore, users must be of a certain age to access such content. By using the App, you represent that you are of the required age to access such content, and you agree to comply with any age restrictions.\n'),
      const TextSpan(
          text: '\n5. Liability', style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nThe App owner is not responsible for any damages caused by the App, including any interruptions or errors that may occur during video playback. You agree to use the App at your own risk.\n'),
      const TextSpan(
          text: '\n6. Termination', style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nThe App owner reserves the right to terminate your access to the App at any time, for any reason, without prior notice.\n'),
      const TextSpan(
          text: '\n7. Indemnification', style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nYou agree to indemnify and hold the App owner harmless from any claims, damages, liabilities, and expenses arising out of your use of the App or any violation of this Agreement.\n'),
      const TextSpan(
          text: '\n8. Governing Law', style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nThis Agreement shall be governed by and construed in accordance with the laws of the jurisdiction in which the App owner is located.\n'),
      const TextSpan(
          text: '\n9. Amendments', style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nThe App owner reserves the right to amend this Agreement at any time, and your continued use of the App constitutes your agreement to the amended Agreement.\n'),
      const TextSpan(
          text:
              '\nIf you have any questions about this Agreement, please contact us at [insert contact information].\n'),
    ]),
  );

  static final privacyPolicy = RichText(
    text: TextSpan(style: CustomeTextStyle.defultText, children: [
      TextSpan(
          text: 'Privacy Policy\n'.toUpperCase(),
          style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nSV Player is a video player app that provides video playback functionality. We take your privacy seriously and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and disclose information about you in connection with your use of the SV Player app.\n'),
      const TextSpan(
          text: '\nInformation We Don\'t Collect',
          style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nWe do not collect any personal information from you when you use the SV Player app. We do not collect your name, email address, phone number, location, or any other personally identifiable information.\n'),
      const TextSpan(
          text: '\nInformation We Collect',
          style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nWe do not collect any personal information from you when you use the SV Player app. We do not use cookies, tracking pixels, or any other tracking technologies to collect information about your use of the app.\n'),
      const TextSpan(
          text: '\nHow We Use Your Information',
          style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nSince we do not collect any personal information from you, we do not use your information in any way. We do not sell, rent, or share any information about you with any third parties.\n'),
      const TextSpan(
          text: '\nUpdates to Our Privacy Policy',
          style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nWe reserve the right to update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.\n'),
      const TextSpan(text: '\nContact Us', style: CustomeTextStyle.headingText),
      const TextSpan(
          text:
              '\nIf you have any questions or concerns about our Privacy Policy, please contact us at support@svplayer.com.\n'),
    ]),
  );
}
