import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SharePage extends StatelessWidget {
  final String title;
  final String url;

  const SharePage({super.key, required this.title, required this.url});

  void _shareToWhatsApp(BuildContext context) async {
    final uri = Uri.parse("https://wa.me/?text=${Uri.encodeComponent('$title\n$url')}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("WhatsApp not installed")));
    }
  }

  void _shareToMessenger(BuildContext context) async {
    final uri = Uri.parse("fb-messenger://share?link=${Uri.encodeComponent(url)}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Messenger not installed")));
    }
  }

  void _shareToFacebook(BuildContext context) async {
    final uri = Uri.parse("https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Facebook not available")));
    }
  }

  void _shareToInstagram(BuildContext context) {
    // Instagram doesn't support direct link sharing; fallback to general share
    Share.share('$title\n$url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Share Article")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(title),
            const SizedBox(height: 16),
            Text("URL:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(url),
            const SizedBox(height: 32),

            Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                    iconSize: 40,
                    tooltip: "WhatsApp",
                    onPressed: () => _shareToWhatsApp(context),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebookMessenger, color: Colors.blue),
                    iconSize: 40,
                    tooltip: "Messenger",
                    onPressed: () => _shareToMessenger(context),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.indigo),
                    iconSize: 40,
                    tooltip: "Facebook",
                    onPressed: () => _shareToFacebook(context),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.purple),
                    iconSize: 40,
                    tooltip: "Instagram",
                    onPressed: () => _shareToInstagram(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check),
                label: const Text("Done"),
              ),
            )
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class Share  extends StatelessWidget {
//   const Share ({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); 
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: [
//             const Text(
//               'Share via',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 100),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildShareIcon(FontAwesomeIcons.whatsapp, Colors.green, 'WhatsApp'),
//                 _buildShareIcon(Icons.facebook, Colors.blue, 'Facebook'),
//                 _buildShareIcon(Icons.message, Colors.blueAccent, 'Messenger'),
//                 _buildShareIcon(Icons.email, Colors.redAccent, 'Email'),
//               ],
//             ),
//             const Spacer(),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 100),
//               child: ElevatedButton(
//                 onPressed: () {
                 
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Share action triggered')),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//                   shape: const StadiumBorder(),backgroundColor: Colors.deepOrange
//                 ),
                
//                 child: 
//                 const Text('Share',style: TextStyle(color: Colors.white),),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildShareIcon(IconData icon, Color color, String label) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 28,
//           backgroundColor: color.withOpacity(0.1),
//           child: Icon(icon, size: 30, color: color),
//         ),
//         const SizedBox(height: 8),
//         Text(label, style: const TextStyle(fontSize: 12)),
//       ],
//     );
//   }
// }
