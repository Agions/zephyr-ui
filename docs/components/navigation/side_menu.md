# ZephyrSideMenu 侧边菜单组件

侧边菜单组件是ZephyrUI导航系统的重要组件，提供了灵活的侧边栏导航功能。支持多种布局模式、动画效果和自定义样式，是构建后台管理系统、移动端导航的理想选择。

## 🎯 组件概述

### 特性
- **多种布局模式**: 支持左侧、右侧、顶部、底部等多种布局
- **流畅动画**: 内置平滑的滑入/滑出动画效果
- **灵活布局**: 支持自定义宽度、高度和位置
- **丰富交互**: 支持点击、悬停、拖拽等交互方式
- **响应式设计**: 根据屏幕尺寸自动调整布局
- **主题适配**: 完整的主题系统支持

### 适用场景
- 后台管理系统
- 移动端导航菜单
- 设置页面
- 应用程序主菜单
- 分类导航
- 用户中心

## 🚀 基础用法

### 基本侧边菜单

```dart
class SideMenuExample extends StatefulWidget {
  @override
  _SideMenuExampleState createState() => _SideMenuExampleState();
}

class _SideMenuExampleState extends State<SideMenuExample> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('侧边菜单示例'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => setState(() => _isMenuOpen = true),
        ),
      ),
      body: Center(
        child: Text('主内容区域'),
      ),
      // 侧边菜单
      drawer: ZephyrSideMenu(
        isOpen: _isMenuOpen,
        onClose: () => setState(() => _isMenuOpen = false),
        width: 280,
        child: Column(
          children: [
            _buildMenuHeader(),
            SizedBox(height: 16),
            _buildMenuItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuHeader() {
    return ZephyrContainer(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.blue),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '用户名',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildMenuItem(
            icon: Icons.dashboard,
            title: '仪表板',
            onTap: () => _handleMenuTap('仪表板'),
          ),
          _buildMenuItem(
            icon: Icons.users,
            title: '用户管理',
            onTap: () => _handleMenuTap('用户管理'),
          ),
          _buildMenuItem(
            icon: Icons.settings,
            title: '系统设置',
            onTap: () => _handleMenuTap('系统设置'),
          ),
          _buildMenuItem(
            icon: Icons.analytics,
            title: '数据分析',
            onTap: () => _handleMenuTap('数据分析'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _handleMenuTap(String menu) {
    setState(() => _isMenuOpen = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了: $menu')),
    );
  }
}
```

### 永久侧边菜单

```dart
class PermanentSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 永久侧边菜单
          ZephyrSideMenu(
            isPermanent: true,
            width: 240,
            elevation: 4,
            child: Column(
              children: [
                _buildLogo(),
                SizedBox(height: 24),
                _buildMenuItems(),
              ],
            ),
          ),
          // 主内容区域
          Expanded(
            child: ZephyrContainer(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '主内容区域',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('这是一个永久侧边菜单的示例。'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return ZephyrContainer(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.apps, size: 32, color: Colors.blue),
          SizedBox(width: 12),
          Text(
            '应用名称',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildMenuItem(
            icon: Icons.home,
            title: '首页',
            isActive: true,
          ),
          _buildMenuItem(icon: Icons.work, title: '项目'),
          _buildMenuItem(icon: Icons.people, title: '团队'),
          _buildMenuItem(icon: Icons.calendar, title: '日历'),
          _buildMenuItem(icon: Icons.message, title: '消息'),
          Divider(),
          _buildMenuItem(icon: Icons.settings, title: '设置'),
          _buildMenuItem(icon: Icons.help, title: '帮助'),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    bool isActive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.blue : Colors.grey[600],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.black87,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isActive ? Colors.blue.withOpacity(0.1) : null,
      onTap: () => _handleMenuTap(title),
    );
  }

  void _handleMenuTap(String menu) {
    print('点击菜单: $menu');
  }
}
```

### 响应式侧边菜单

```dart
class ResponsiveSideMenu extends StatefulWidget {
  @override
  _ResponsiveSideMenuState createState() => _ResponsiveSideMenuState();
}

class _ResponsiveSideMenuState extends State<ResponsiveSideMenu> {
  bool _isMenuOpen = false;
  bool _isPermanent = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    
    // 自动根据屏幕宽度调整模式
    if (isDesktop && !_isPermanent) {
      _isPermanent = true;
    } else if (!isDesktop && _isPermanent) {
      _isPermanent = false;
    }

    return Scaffold(
      appBar: !_isPermanent
          ? AppBar(
              title: Text('响应式侧边菜单'),
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => setState(() => _isMenuOpen = true),
              ),
            )
          : null,
      body: Row(
        children: [
          // 侧边菜单
          if (_isPermanent)
            ZephyrSideMenu(
              isPermanent: true,
              width: 240,
              child: _buildMenuContent(),
            ),
          // 主内容区域
          Expanded(
            child: ZephyrContainer(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '响应式设计',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '屏幕宽度: ${screenWidth.round()}px',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '菜单模式: ${_isPermanent ? "永久" : "抽屉"}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // 抽屉式菜单
      drawer: !_isPermanent
          ? ZephyrSideMenu(
              isOpen: _isMenuOpen,
              onClose: () => setState(() => _isMenuOpen = false),
              width: 280,
              child: _buildMenuContent(),
            )
          : null,
    );
  }

  Widget _buildMenuContent() {
    return Column(
      children: [
        _buildMenuHeader(),
        SizedBox(height: 16),
        _buildMenuItems(),
      ],
    );
  }

  Widget _buildMenuHeader() {
    return ZephyrContainer(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 16),
          Text(
            '菜单',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildMenuItem(Icons.home, '首页'),
          _buildMenuItem(Icons.dashboard, '仪表板'),
          _buildMenuItem(Icons.work, '项目'),
          _buildMenuItem(Icons.people, '团队'),
          _buildMenuItem(Icons.settings, '设置'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => _handleMenuTap(title),
    );
  }

  void _handleMenuTap(String menu) {
    if (!_isPermanent) {
      setState(() => _isMenuOpen = false);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了: $menu')),
    );
  }
}
```

## 🎨 样式定制

### 自定义样式

```dart
ZephyrSideMenu(
  isOpen: _isMenuOpen,
  onClose: () => setState(() => _isMenuOpen = false),
  width: 300,
  elevation: 8,
  borderRadius: 16,
  backgroundColor: Colors.grey[50],
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue[50]!,
        Colors.purple[50]!,
      ],
    ),
  ),
  child: _buildCustomMenuContent(),
)
```

### 带动画的侧边菜单

```dart
class AnimatedSideMenu extends StatefulWidget {
  @override
  _AnimatedSideMenuState createState() => _AnimatedSideMenuState();
}

class _AnimatedSideMenuState extends State<AnimatedSideMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画侧边菜单'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _toggleMenu,
        ),
      ),
      body: Stack(
        children: [
          // 主内容区域
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: ZephyrContainer(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text('主内容区域'),
              ),
            ),
          ),
          // 遮罩层
          if (_isMenuOpen)
            GestureDetector(
              onTap: _toggleMenu,
              child: ZephyrContainer(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          // 侧边菜单
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  _slideAnimation.value * MediaQuery.of(context).size.width,
                  0,
                ),
                child: child,
              );
            },
            child: ZephyrSideMenu(
              isOpen: true,
              width: 280,
              elevation: 16,
              borderRadius: 0,
              child: _buildMenuContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuContent() {
    return Column(
      children: [
        _buildMenuHeader(),
        SizedBox(height: 16),
        _buildMenuItems(),
      ],
    );
  }

  Widget _buildMenuHeader() {
    return ZephyrContainer(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.purple],
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 16),
          Text(
            '动画菜单',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildAnimatedMenuItem(Icons.home, '首页', 0),
          _buildAnimatedMenuItem(Icons.dashboard, '仪表板', 1),
          _buildAnimatedMenuItem(Icons.work, '项目', 2),
          _buildAnimatedMenuItem(Icons.people, '团队', 3),
          _buildAnimatedMenuItem(Icons.settings, '设置', 4),
        ],
      ),
    );
  }

  Widget _buildAnimatedMenuItem(IconData icon, String title, int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final delay = index * 100;
        final progress = _animationController.value;
        final opacity = progress > (delay / 300) ? 1.0 : 0.0;
        final offset = progress > (delay / 300) 
            ? 0.0 
            : (1.0 - progress * 3) * 50;
        
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(offset, 0),
            child: child,
          ),
        );
      },
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () => _handleMenuTap(title),
      ),
    );
  }

  void _handleMenuTap(String menu) {
    _toggleMenu();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了: $menu')),
    );
  }
}
```

## 🔧 高级用法

### 多级菜单

```dart
class MultiLevelSideMenu extends StatefulWidget {
  @override
  _MultiLevelSideMenuState createState() => _MultiLevelSideMenuState();
}

class _MultiLevelSideMenuState extends State<MultiLevelSideMenu> {
  bool _isMenuOpen = false;
  String? _expandedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('多级菜单'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => setState(() => _isMenuOpen = true),
        ),
      ),
      body: Center(
        child: Text('主内容区域'),
      ),
      drawer: ZephyrSideMenu(
        isOpen: _isMenuOpen,
        onClose: () => setState(() => _isMenuOpen = false),
        width: 280,
        child: Column(
          children: [
            _buildMenuHeader(),
            SizedBox(height: 16),
            _buildMultiLevelMenuItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuHeader() {
    return ZephyrContainer(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 16),
          Text(
            '多级菜单',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiLevelMenuItems() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildMenuItem(Icons.home, '首页'),
          SizedBox(height: 8),
          _buildExpandableCategory(
            icon: Icons.work,
            title: '项目管理',
            subItems: [
              _buildSubMenuItem('项目列表', Icons.list),
              _buildSubMenuItem('创建项目', Icons.add),
              _buildSubMenuItem('项目统计', Icons.analytics),
            ],
          ),
          SizedBox(height: 8),
          _buildExpandableCategory(
            icon: Icons.people,
            title: '用户管理',
            subItems: [
              _buildSubMenuItem('用户列表', Icons.person),
              _buildSubMenuItem('角色管理', Icons.admin_panel_settings),
              _buildSubMenuItem('权限设置', Icons.security),
            ],
          ),
          SizedBox(height: 8),
          _buildMenuItem(Icons.settings, '设置'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => _handleMenuTap(title),
    );
  }

  Widget _buildExpandableCategory({
    required IconData icon,
    required String title,
    required List<Widget> subItems,
  }) {
    final isExpanded = _expandedCategory == title;
    
    return ZephyrContainer(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isExpanded ? Colors.blue.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon),
            title: Text(title),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: () => setState(() {
              _expandedCategory = isExpanded ? null : title;
            }),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                children: subItems,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSubMenuItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, size: 20),
      title: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
      onTap: () => _handleMenuTap(title),
    );
  }

  void _handleMenuTap(String menu) {
    setState(() => _isMenuOpen = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了: $menu')),
    );
  }
}
```

### 带搜索的侧边菜单

```dart
class SearchableSideMenu extends StatefulWidget {
  @override
  _SearchableSideMenuState createState() => _SearchableSideMenuState();
}

class _SearchableSideMenuState extends State<SearchableSideMenu> {
  bool _isMenuOpen = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.home, 'title': '首页', 'category': '基础'},
    {'icon': Icons.dashboard, 'title': '仪表板', 'category': '基础'},
    {'icon': Icons.work, 'title': '项目管理', 'category': '业务'},
    {'icon': Icons.people, 'title': '用户管理', 'category': '业务'},
    {'icon': Icons.analytics, 'title': '数据分析', 'category': '分析'},
    {'icon': Icons.report, 'title': '报表中心', 'category': '分析'},
    {'icon': Icons.settings, 'title': '系统设置', 'category': '系统'},
    {'icon': Icons.security, 'title': '安全设置', 'category': '系统'},
    {'icon': Icons.help, 'title': '帮助中心', 'category': '支持'},
    {'icon': Icons.feedback, 'title': '意见反馈', 'category': '支持'},
  ];

  List<Map<String, dynamic>> get _filteredItems {
    if (_searchQuery.isEmpty) {
      return _menuItems;
    }
    return _menuItems.where((item) {
      return item['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
             item['category'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可搜索菜单'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => setState(() => _isMenuOpen = true),
        ),
      ),
      body: Center(
        child: Text('主内容区域'),
      ),
      drawer: ZephyrSideMenu(
        isOpen: _isMenuOpen,
        onClose: () => setState(() => _isMenuOpen = false),
        width: 300,
        child: Column(
          children: [
            _buildMenuHeader(),
            SizedBox(height: 16),
            _buildSearchBox(),
            SizedBox(height: 16),
            _buildFilteredMenuItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuHeader() {
    return ZephyrContainer(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 16),
          Text(
            '搜索菜单',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return ZephyrContainer(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: '搜索菜单项',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        onChanged: (value) {
          setState(() => _searchQuery = value);
        },
      ),
    );
  }

  Widget _buildFilteredMenuItems() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (_searchQuery.isNotEmpty && _filteredItems.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      '未找到相关菜单项',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ..._filteredItems.map((item) {
            return _buildMenuItem(
              icon: item['icon'],
              title: item['title'],
              category: item['category'],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String category,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(category),
      onTap: () => _handleMenuTap(title),
    );
  }

  void _handleMenuTap(String menu) {
    setState(() => _isMenuOpen = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了: $menu')),
    );
  }
}
```

## 🎛️ API 参考

### 构造函数

#### ZephyrSideMenu()

```dart
const ZephyrSideMenu({
  Key? key,
  required Widget child,
  bool isOpen = false,
  bool isPermanent = false,
  double? width,
  double? height,
  double elevation = 4,
  double borderRadius = 0,
  Color? backgroundColor,
  Decoration? decoration,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  VoidCallback? onClose,
  Duration? animationDuration,
  Curve? animationCurve,
  bool showOverlay = true,
  Color? overlayColor,
  double overlayOpacity = 0.3,
  ZephyrSideMenuPosition position = ZephyrSideMenuPosition.left,
  bool enableDrag = true,
  bool enableGestures = true,
  String? semanticLabel,
  bool enableAccessibilityFeatures = true,
})
```

**参数说明：**
- `child`: 菜单内容
- `isOpen`: 是否打开
- `isPermanent`: 是否为永久菜单
- `width`: 菜单宽度
- `height`: 菜单高度
- `elevation`: 阴影高度
- `borderRadius`: 边框圆角
- `backgroundColor`: 背景颜色
- `decoration`: 装饰
- `padding`: 内边距
- `margin`: 外边距
- `onClose`: 关闭回调
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `showOverlay`: 是否显示遮罩层
- `overlayColor`: 遮罩层颜色
- `overlayOpacity`: 遮罩层透明度
- `position`: 菜单位置
- `enableDrag`: 是否启用拖拽
- `enableGestures`: 是否启用手势
- `semanticLabel`: 语义标签
- `enableAccessibilityFeatures`: 是否启用无障碍功能

### 枚举类型

#### ZephyrSideMenuPosition

```dart
enum ZephyrSideMenuPosition {
  left,   // 左侧
  right,  // 右侧
  top,    // 顶部
  bottom, // 底部
}
```

## 🎨 主题配置

### 主题数据

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      ZephyrSideMenuTheme(
        defaultWidth: 280,
        defaultElevation: 4,
        defaultBorderRadius: 0,
        defaultBackgroundColor: Colors.white,
        defaultPadding: EdgeInsets.all(16),
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        overlayColor: Colors.black,
        overlayOpacity: 0.3,
        selectedColor: Colors.blue.withOpacity(0.1),
        hoverColor: Colors.grey.withOpacity(0.1),
        textStyle: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        selectedTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
        iconColor: Colors.grey[600],
        selectedIconColor: Colors.blue,
      ),
    ],
  ),
  home: MyApp(),
)
```

### 主题属性

- `defaultWidth`: 默认宽度
- `defaultElevation`: 默认阴影高度
- `defaultBorderRadius`: 默认圆角
- `defaultBackgroundColor`: 默认背景颜色
- `defaultPadding`: 默认内边距
- `animationDuration`: 动画持续时间
- `animationCurve`: 动画曲线
- `overlayColor`: 遮罩层颜色
- `overlayOpacity`: 遮罩层透明度
- `selectedColor`: 选中颜色
- `hoverColor`: 悬停颜色
- `textStyle`: 文本样式
- `selectedTextStyle`: 选中文本样式
- `iconColor`: 图标颜色
- `selectedIconColor`: 选中图标颜色

## 🏆 最佳实践

### 1. 合理的菜单宽度

```dart
// ✅ 好的做法：根据使用场景设置合适的宽度
ZephyrSideMenu(
  width: 240, // 适合桌面端
  child: _buildMenuContent(),
)

// ✅ 好的做法：移动端使用更窄的宽度
ZephyrSideMenu(
  width: 280, // 适合移动端
  child: _buildMenuContent(),
)

// ❌ 避免的做法：宽度过大
ZephyrSideMenu(
  width: 400, // 占用过多屏幕空间
  child: _buildMenuContent(),
)
```

### 2. 响应式设计

```dart
// ✅ 好的做法：根据屏幕尺寸调整菜单模式
class ResponsiveSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    
    return Scaffold(
      body: Row(
        children: [
          if (isDesktop)
            ZephyrSideMenu(
              isPermanent: true,
              width: 240,
              child: _buildMenuContent(),
            ),
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
      drawer: !isDesktop
          ? ZephyrSideMenu(
              width: 280,
              child: _buildMenuContent(),
            )
          : null,
    );
  }
}
```

### 3. 性能优化

```dart
// ✅ 好的做法：使用const构造函数优化性能
const ZephyrSideMenu(
  width: 280,
  elevation: 4,
  child: MenuContent(),
)

// ✅ 好的做法：避免在菜单中使用复杂的动画
ZephyrSideMenu(
  child: ListView(
    children: [
      _buildSimpleMenuItem(),
      _buildSimpleMenuItem(),
    ],
  ),
)

// ❌ 避免的做法：在菜单中使用复杂的动画
ZephyrSideMenu(
  child: ListView(
    children: [
      _buildComplexAnimatedMenuItem(),
      _buildComplexAnimatedMenuItem(),
    ],
  ),
)
```

### 4. 无障碍设计

```dart
// ✅ 好的做法：为菜单添加语义标签
ZephyrSideMenu(
  semanticLabel: '主导航菜单',
  enableAccessibilityFeatures: true,
  child: _buildMenuContent(),
)

// ✅ 好的做法：为菜单项添加描述
ListTile(
  leading: Icon(Icons.home),
  title: Text('首页'),
  onTap: () => _navigateToHome(),
  subtitle: Text('返回主页面'),
)

// ❌ 避免的做法：缺乏语义信息
ZephyrSideMenu(
  child: ListView(
    children: [
      ListTile(
        title: Text('首页'),
        onTap: () => _navigateToHome(),
      ),
    ],
  ),
)
```

## 🔄 相关组件

- **ZephyrTabs**: 选项卡组件
- **ZephyrBottomNavigationBar**: 底部导航栏
- **ZephyrBreadcrumb**: 面包屑导航
- **ZephyrNavigationRail**: 导航栏组件

## 📝 更新日志

### v1.0.0
- ✅ 初始版本发布
- ✅ 支持基础侧边菜单功能
- ✅ 支持永久和抽屉模式
- ✅ 支持响应式设计
- ✅ 完整的主题系统支持

---

**组件路径**: `lib/src/components/navigation/side_menu/`
**示例路径**: `example/lib/components/side_menu_demo.dart`
**文档版本**: 1.0.0
**最后更新**: 2025年8月20日