import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MenuApp());
}

class MenuApp extends StatefulWidget {
  @override
  _MenuAppState createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> {
  late String _selectedLanguageCode;

  final _supportedLanguages = [
    Locale('en', 'US'),
    Locale('fr', 'FR'),
  ];

  final _supportedLanguageCodes = ['en', 'fr'];

  @override
  void initState() {
    super.initState();
    _selectedLanguageCode = _supportedLanguageCodes[0];
  }

  Future<void> _selectLanguage(BuildContext context) async {
    Locale _locale = await showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Text('Select a language'),
        children: _supportedLanguages
            .map(
              (locale) => SimpleDialogOption(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(locale),
            child: Text(locale.languageCode),
          ),
        )
            .toList(),
      ),
    );
    if (_locale != null) {
      setState(() {
        _selectedLanguageCode = _locale.languageCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thực đơn 7 món nước',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      supportedLocales: _supportedLanguages,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      locale: Locale(_selectedLanguageCode),
      home: MenuScreen(_selectLanguage),
    );
  }
}

class MenuScreen extends StatefulWidget {
  final Function(BuildContext) onSelectLanguage;

  MenuScreen(this.onSelectLanguage);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String selectedItem = '';

  List<Map<String, dynamic>> menu = [
    {
      'title': 'Beer',
      'description':
      'Bia là một loại đồ uống có cồn được làm từ lúa mạch lên men. Nó có vị đắng và là một sự kết hợp giữa hương thơm và vị ngon. Beer thường được uống để thưởng thức và làm dịu cơn khát.',
      'image': 'beer.png',
    },
    {
      'title': 'Coconut Cocktail',
      'description':
      'Cocktail Dừa là một loại đồ uống có cồn được làm từ nước dừa và các thành phần pha trộn khác như rượu trắng, nước chanh, đường và đá. Nó có hương vị tươi mát, ngọt ngào và hương thơm của nước dừa tạo nên sự thú vị và hấp dẫn. Coconut Cocktail thường được thưởng thức trong các bữa tiệc và dịp họp mặt, đem lại cảm giác tròn đầy nhiệt huyết và sảng khoái.',
      'image': 'coconutcocktail.png',
    },
    {
      'title': 'Lemonade',
      'description':
      'Nước chanh là một đồ uống không cồn có vị chua ngọt và hương thơm tươi mát của chanh. Nó được làm từ nước chanh, đường và nước. Lemonade thường được uống để giải khát và làm dịu cơn khát trong những ngày nóng.',
      'image': 'lemonade.png',
    },
    {
      'title': 'Milkshake',
      'description':
      'Sữa lắc là một loại đồ uống ngọt ngào được làm từ sữa, kem và hương vị thêm vào như chocolate, vani, hoa quả, hạt dẻ, hoặc caramel. Nó thường được kết hợp với đá hoặc kem đánh bông để tạo thành một cốc uống mịn màng và béo ngậy. Milkshake là một lựa chọn phổ biến cho việc thưởng thức và làm dịu cơn khát, đặc biệt là trong những ngày nóng.',
      'image': 'milkshake.png',
    },
    {
      'title': 'Orange Juice',
      'description':
      'Nước cam là một loại nước ép được làm từ quả cam. Nó có màu vàng tươi sáng và vị chua ngọt tự nhiên của cam. Orange Juice thường được uống để thưởng thức và cung cấp vitamin C và các dưỡng chất có lợi cho sức khỏe. Nó là một lựa chọn phổ biến cho việc giải khát và bổ sung dinh dưỡng trong suốt cả ngày.',
      'image': 'orangejuice.png',
    },
    {
      'title': 'Apple Juice',
      'description':
      'Nước ép táo là một loại đồ uống được làm từ quả táo tươi bằng cách ép hoặc xay nhuyễn. Nó có màu vàng hoặc hơi nâu, vị ngọt tự nhiên và hương thơm tươi mát của táo. Nước ép táo thường được coi là một nguồn cung cấp vitamin C và chất chống oxi hóa, cũng như chất xơ từ táo. Nó có thể được uống để giải khát, cung cấp năng lượng, và làm dịu cơn khát trong ngày nóng. Đồng thời, nước ép táo cũng có thể được sử dụng làm thành phần trong các cocktail, smoothie hoặc các món ăn khác để tăng thêm hương vị táo tươi mát.',
      'image': 'applejuice.jpg',
    },
    {
      'title': 'Matcha Milk Tea',
      'description':
      'Trà sữa Matcha  là một loại đồ uống pha trộn từ bột trà xanh Matcha và sữa. Nó là một sự kết hợp giữa hương vị đắng ngọt của trà xanh Matcha và mịn màng, béo ngậy của sữa. Matcha Milk Tea thường được pha chế bằng cách kết hợp bột Matcha, sữa và đường, sau đó đánh bông hoặc lắc để tạo ra một cốc uống mềm mịn và thơm ngon. Đây là một loại đồ uống phổ biến trong nền văn hóa trà của Nhật Bản và cũng được yêu thích trên toàn thế giới. Nó thường được thưởng thức trong các quán trà, quán cà phê, và có thể được tùy chỉnh với thêm đá, trân châu, hoặc các topping khác để tạo thêm hương vị và texture.',
      'image': 'matcha.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)?.translate('menu_title') ?? '7 Beverage Menu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => widget.onSelectLanguage(context),
            icon: Icon(Icons.translate),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(AppLocalizations.of(context)?.translate('order_button') ?? 'Order'),
          icon: Icon(Icons.add_shopping_cart),
          backgroundColor: Colors.green[900],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: AssetImage('images/coconutcocktail.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.translate('menu_title') ?? '7 Beverage Menu',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)?.translate('menu_subtitle') ?? 'Prices range from 20,000 VND - 50,000 VND',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green[900],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    AppLocalizations.of(context)?.translate('menu') ?? 'Menu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: menu.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedItem = menu[index]['title'];
                        });
                        _controller.reset();
                        _controller.forward();
                      },
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                  AssetImage('images/${menu[index]['image']}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menu[index]['title'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    menu[index]['description'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow[700],
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '4.5 (50+ reviews)',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            top: selectedItem.isNotEmpty ? 0 : -100,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.green[900],
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${AppLocalizations.of(context)?.translate('selected_item') ?? 'You have selected'} ${selectedItem}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedItem = '';
                      });
                      _controller.reset();
                      _controller.forward();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'menu_title': '7 Beverage Menu',
      'menu_subtitle': 'Prices range from 20,000 VND - 50,000 VND',
      'menu': 'Menu',
      'order_button': 'Order',
      'selected_item': 'You have selected',
    },
    'fr': {
      'menu_title': '7 Menu de boissons',
      'menu_subtitle': 'Les prix varient entre 20,000 VND et 50,000 VND',
      'menu': 'Menu',
      'order_button': 'Commander',
      'selected_item': 'Vous avez sélectionné',
    },
  };

  String translate(String key) {
    final Map<String, String>? translations = _localizedValues[locale.languageCode];
    return translations != null ? translations[key] ?? key : key;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) {
    return false;
  }
}