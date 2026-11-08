import 'package:flutter/material.dart';

class MarketingToggleCard extends StatefulWidget {
  const MarketingToggleCard({super.key});

  @override
  State<MarketingToggleCard> createState() => _MarketingToggleCardState();
}

class _MarketingToggleCardState extends State<MarketingToggleCard> {
  bool _isToggled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B22),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Send me discounts and other offers by email. Opt out any time in your settings',
              style: TextStyle(color: Colors.white, fontSize: 14, height: 1.3),
            ),
          ),
          const SizedBox(width: 16),
          Switch.adaptive(
            value: _isToggled,
            activeColor: Colors.blue,
            onChanged: (value) {
              setState(() {
                _isToggled = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
