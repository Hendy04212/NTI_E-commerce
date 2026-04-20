import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/cache/cache_data.dart';
import '../../../core/cache/cache_keys.dart';
import '../../../core/translation/translation_helper.dart';
import '../../../core/translation/translation_keys.dart';


class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String _selectedLanguage = CacheData.lang == CacheKeys.keyAR ? 'AR' : 'EN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationKeys.settings.tr),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(TranslationKeys.language.tr, style: TextStyle(fontSize: 16)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedLanguage = 'AR';
                    });
                    TranslationHelper.changeLanguage(true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedLanguage == 'AR' ? Colors.pink : Colors.grey[300],
                    foregroundColor: _selectedLanguage == 'AR' ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    minimumSize: Size(40, 30),
                  ),
                  child: Text('AR', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedLanguage = 'EN';
                    });
                    TranslationHelper.changeLanguage(false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedLanguage == 'EN' ? Colors.pink : Colors.grey[300],
                    foregroundColor: _selectedLanguage == 'EN' ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    minimumSize: Size(40, 30),
                  ),
                  child: Text('EN', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          // ممكن تضيف هنا خيارات إعدادات تانية
        ],
      ),
    );
  }
}