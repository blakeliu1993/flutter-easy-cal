import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easycal/logic/transfer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final int _maxLength = 10;
  bool _isDarkMode = false;
  final Transfer _transfer = Transfer(
    unitType: UnitType.distance,
    sourceUnit: 0,
    targetUnit: 1,
  );
  List<String> _unitLists = [];
  List<String> _sourceUnitLists = ['Km'];
  List<String> _targetUnitList = ['M'];
  List<String> _resetUnitList = [];
  final TextEditingController _sourceUnitController = TextEditingController();
  final TextEditingController _targetUnitController = TextEditingController();
  final Map<UnitType, String> _backgroundImages = {
    UnitType.distance: 'assets/images/background-img-ruler.png',
    UnitType.weight: 'assets/images/background-img-scale.png',
    UnitType.temperature: 'assets/images/background-img-thermometer.png',
  };
  final Map<UnitType, IconData> _backgroundIcons = {
    UnitType.distance: FontAwesomeIcons.ruler,
    UnitType.weight: FontAwesomeIcons.weightHanging,
    UnitType.temperature: FontAwesomeIcons.temperatureHalf,
  };

  @override
  void initState() {
    super.initState();
    _initUnitLists();
    _sourceUnitController.text = _unitLists[_transfer.sourceUnit];
    _targetUnitController.text = _unitLists[_transfer.targetUnit];
  }

  void _initUnitLists() {
    switch (_transfer.unitType) {
      case UnitType.distance:
        _unitLists = DistanceUnit.values.map((e) => e.name).toList();
        _sourceUnitLists = _unitLists;
        _targetUnitList = _unitLists;
        _resetUnitList = _unitLists;

        break;
      case UnitType.temperature:
        _unitLists = TemperatureUnit.values.map((e) => e.name).toList();
        _sourceUnitLists = _unitLists;
        _targetUnitList = _unitLists;
        _resetUnitList = _unitLists;
        break;
      case UnitType.weight:
        _unitLists = WeightUnit.values.map((e) => e.name).toList();
        _sourceUnitLists = _unitLists;
        _targetUnitList = _unitLists;
        _resetUnitList = _unitLists;
        break;
    }
  }

  void _sourceTextChanged(String value) {
    if (value.isNotEmpty && double.tryParse(value) != null) {
      double targetValue = _transfer.transfer(double.parse(value));
      _targetController.text = targetValue.toStringAsFixed(2);
      setState(() {
        _resetUnitList = List<String>.from(_resetUnitList);
      });
    } else {
      _targetController.text = '';
    }
  }

  // ? switch source and target unit.
  void _exchangeSourceTarget() {
    var tmpUnit = _transfer.sourceUnit;
    _transfer.setSourceUnit(_transfer.targetUnit);
    _transfer.setTargetUnit(tmpUnit);
    var tmp = _sourceUnitLists;
    _sourceUnitLists = _targetUnitList;
    _targetUnitList = tmp;
    setState(() {
      var tmps = _sourceUnitController.text;
      _sourceUnitController.text = _targetUnitController.text;
      _targetUnitController.text = tmps;
      _targetController.text =
          _transfer
              .transfer(
                double.parse(
                  _sourceController.text.isEmpty ? '0' : _sourceController.text,
                ),
              )
              .toString();
    });
  }

  void _switchTheme(bool value) {
    if (mounted) {
      setState(() {
        _isDarkMode = value;
      });
    }
  }

  void _switchToDistance() {
    _transfer.setUnitType(UnitType.distance);
    _transfer.setSourceUnit(0);
    _transfer.setTargetUnit(1);
    _initUnitLists();
    _sourceUnitController.text = _unitLists[_transfer.sourceUnit];
    _targetUnitController.text = _unitLists[_transfer.targetUnit];
    _sourceController.text = '';
    _targetController.text = '';
    if (mounted) {
      setState(() {
        _sourceUnitLists;
        _targetUnitList;
        _resetUnitList =
            _unitLists
                .where(
                  (e) =>
                      e != _sourceUnitController.text &&
                      e != _targetUnitController.text,
                )
                .toList();
      });
    }

    Navigator.pop(context);
  }

  void _switchToWeight() {
    _transfer.setUnitType(UnitType.weight);
    _transfer.setSourceUnit(0);
    _transfer.setTargetUnit(1);
    _initUnitLists();
    _sourceUnitController.text = _unitLists[_transfer.sourceUnit];
    _targetUnitController.text = _unitLists[_transfer.targetUnit];
    _sourceController.text = '';
    _targetController.text = '';
    if (mounted) {
      setState(() {
        _sourceUnitLists;
        _targetUnitList;
        _resetUnitList =
            _unitLists
                .where(
                  (e) =>
                      e != _sourceUnitController.text &&
                      e != _targetUnitController.text,
                )
                .toList();
      });
    }
    Navigator.pop(context);
  }

  void _switchToTemperature() {
    _transfer.setUnitType(UnitType.temperature);
    _transfer.setSourceUnit(0);
    _transfer.setTargetUnit(1);
    _initUnitLists();
    _sourceUnitController.text = _unitLists[_transfer.sourceUnit];
    _targetUnitController.text = _unitLists[_transfer.targetUnit];
    _sourceController.text = '';
    _targetController.text = '';
    if (mounted) {
      setState(() {
        _sourceUnitLists;
        _targetUnitList;
        _resetUnitList =
            _unitLists
                .where(
                  (e) =>
                      e != _sourceUnitController.text &&
                      e != _targetUnitController.text,
                )
                .toList();
      });
    }
    Navigator.pop(context);
  }

  void _selectSourceUnit(String value) {
    //  selected item will removed from targetlist and set _transfer.sourceUnit
    String selectedUnit = value;
    debugPrint('selectedUnit: $selectedUnit');
    _targetUnitList = List<String>.from(
      _unitLists,
    ); // Copy new list avoid unit became less.
    if (mounted) {
      setState(() {
        _targetUnitList.remove(selectedUnit);
      });
    }
    _transfer.setSourceUnit(_unitLists.indexOf(selectedUnit));
    debugPrint('sourceUnitLists: $_sourceUnitLists');
    if (_targetUnitController.text.isNotEmpty) {
      if (mounted) {
        setState(() {
          _resetUnitList =
              List<String>.from(_unitLists)
                  .where(
                    (item) =>
                        _sourceUnitController.text != item &&
                        _targetUnitController.text != item,
                  )
                  .toList();
        });
      }
      debugPrint('resetUnitList: $_resetUnitList');
    }
  }

  void _selectTargetUnit(String value) {
    String selectedUnit = value;
    debugPrint('selectedUnit: $selectedUnit');
    _sourceUnitLists = List<String>.from(_unitLists);
    if (mounted) {
      setState(() {
        _sourceUnitLists.remove(selectedUnit);
      });
    }
    _transfer.setTargetUnit(_unitLists.indexOf(selectedUnit));
    debugPrint('targetUnitList: $_targetUnitList');
    if (_sourceUnitController.text.isNotEmpty) {
      if (mounted) {
        setState(() {
          _resetUnitList =
              List<String>.from(_unitLists)
                  .where(
                    (item) =>
                        _sourceUnitController.text != item &&
                        _targetUnitController.text != item,
                  )
                  .toList();
        });
      }
      debugPrint('resetUnitList: $_resetUnitList');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _sourceController.dispose();
    _targetController.dispose();
    _sourceUnitController.dispose();
    _targetUnitController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double textFieldWidthFactor = 0.5;

    // 1. 定义一个统一的暗色主题，确保前景元素清晰可见
    final darkTheme = ThemeData.dark().copyWith(
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      dividerColor: Colors.white.withValues(alpha: 0.3),
    );

    final lightTheme = ThemeData.light();

    return SafeArea(
      child: Theme(
        // 2. 根据 _isDarkMode 应用我们自定义的主题
        data: _isDarkMode ? darkTheme : lightTheme,
        child: Scaffold(
          extendBody: false,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent, // 使AppBar透明以显示背景
            elevation: 0, // 移除阴影
            title: Text('Uni Converser'),
            centerTitle: true,
            actions: [
              CupertinoSwitch(value: _isDarkMode, onChanged: _switchTheme),
            ],
          ),
          body: Stack(
            // 1. 使用Stack布局
            children: [
              // 2. 这是背景层的巨型弱化图标
              Center(
                child: FaIcon(
                  _backgroundIcons[_transfer.unitType]!,
                  size: screenWidth * 0.7, // 一个很大的尺寸
                  color:
                      _isDarkMode
                          ? Colors.white.withValues(alpha: 0.05) // 在暗色模式下用极淡的白色
                          : Colors.black.withValues(
                            alpha: 0.05,
                          ), // 在亮色模式下用极淡的黑色
                ),
              ),
              // 3. 这是原来的UI内容层
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: screenWidth * textFieldWidthFactor,
                        child: TextField(
                          controller: _sourceController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Source Value ',
                            hintText: 'Enter Source Value',
                            counterText: '',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: _sourceTextChanged,
                          maxLength: _maxLength,
                          autocorrect: false,
                          enableSuggestions: false,
                        ),
                      ),
                      DropdownMenu(
                        controller: _sourceUnitController,
                        dropdownMenuEntries: [
                          for (String unit in _sourceUnitLists)
                            DropdownMenuEntry(value: unit, label: unit),
                        ],
                        onSelected: (value) {
                          _selectSourceUnit(value!);
                        },
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  ElevatedButton(
                    onPressed: _exchangeSourceTarget,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      minimumSize: Size(screenWidth * 1, screenHeight * 0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(
                          color: Colors.green,
                          style: BorderStyle.solid,
                          width: 5,
                        ),
                      ),
                    ),
                    child: Text('Exchange'),
                  ),
                  const Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: screenWidth * textFieldWidthFactor,
                        child: TextField(
                          controller: _targetController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Source Value ',
                            hintText: 'Enter Source Value',
                          ),
                          readOnly: true,
                        ),
                      ),
                      DropdownMenu(
                        controller: _targetUnitController,
                        dropdownMenuEntries: [
                          for (String unit in _targetUnitList)
                            DropdownMenuEntry(value: unit, label: unit),
                        ],
                        onSelected: (value) => _selectTargetUnit(value!),
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  Divider(), // Divider颜色会从主题中获取
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          _backgroundImages[_transfer.unitType]!,
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    height: screenHeight * 0.2,
                    child: ListView.builder(
                      itemCount: _resetUnitList.length,
                      itemBuilder: (BuildContext newContext, int index) {
                        return ListTile(
                          title: Text(_resetUnitList[index]),
                          trailing: Text(
                            (_sourceController.text.isEmpty
                                    ? 0
                                    : _transfer.transfer(
                                      double.parse(_sourceController.text),
                                      newTargetUnit: _resetUnitList[index],
                                    ))
                                .toStringAsFixed(2),
                            style: TextStyle(
                              color:
                                  _isDarkMode
                                      ? Colors.white.withValues(alpha: 0.8)
                                      : Colors.black.withValues(alpha: 0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          drawer: Drawer(
            child: Column(
              children: [
                ListTile(
                  title: Text('Distance'),
                  leading: FaIcon((FontAwesomeIcons.personRunning)),
                  onTap: _switchToDistance,
                ),
                ListTile(
                  title: Text('Weight'),
                  leading: FaIcon((FontAwesomeIcons.weightHanging)),
                  onTap: _switchToWeight,
                ),
                ListTile(
                  title: Text('Temperature'),
                  leading: FaIcon(FontAwesomeIcons.temperatureHalf),
                  onTap: _switchToTemperature,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
