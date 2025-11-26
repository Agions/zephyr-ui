# ZephyrUI Basic 基础组件

本目录包含 ZephyrUI 的基础组件，提供了丰富的 UI 组件来构建现代化的 Flutter 应用。

## 组件列表

### 1. Image 图片组件 (`/image/`)
提供图片加载、占位符、错误处理等功能。

**主要组件：**
- `ZephyrImage` - 基础图片组件
- `ZephyrNetworkImage` - 网络图片组件
- `ZephyrAssetImage` - 资源图片组件
- `ZephyrMemoryImage` - 内存图片组件
- `ZephyrAvatarImage` - 头像图片组件
- `ZephyrImageGallery` - 图片画廊组件

**特性：**
- 支持网络图片、资源图片、内存图片
- 提供占位符和错误处理
- 支持多种形状（矩形、圆形、圆角等）
- 支持多种适配模式
- 提供头像组件，支持文字头像
- 支持图片画廊轮播

### 2. Dropdown 下拉菜单组件 (`/dropdown/`)
提供下拉菜单功能，支持单选、多选、搜索等功能。

**主要组件：**
- `ZephyrDropdown<T>` - 单选下拉菜单
- `ZephyrMultiSelectDropdown<T>` - 多选下拉菜单
- `ZephyrDropdownItem<T>` - 下拉菜单项
- `ZephyrDropdownUtils` - 下拉菜单工具类

**特性：**
- 支持单选和多选
- 支持搜索功能
- 支持自定义样式
- 支持禁用状态
- 支持全选功能
- 支持自定义显示内容

### 3. Tag 标签组件 (`/tag/`)
用于标记和分类的标签组件。

**主要组件：**
- `ZephyrTag` - 基础标签
- `ZephyrCloseableTag` - 可关闭标签
- `ZephyrTagGroup` - 标签组

**特性：**
- 支持多种样式（默认、成功、警告、错误、信息）
- 支持多种大小
- 支持图标和关闭按钮
- 支持点击事件
- 支持标签组布局

### 4. Typography 排版组件 (`/typography/`)
提供标准化的文本排版样式。

**主要组件：**
- `ZephyrTypography` - 基础排版组件
- `ZephyrTitle` - 标题组件
- `ZephyrSubtitle` - 副标题组件
- `ZephyrParagraph` - 段落组件
- `ZephyrCaption` - 说明文字组件
- `ZephyrLink` - 链接组件
- `ZephyrTextBlock` - 文本块组件

**特性：**
- 支持多种文本类型（H1-H6、正文、说明等）
- 支持多种字重
- 支持自定义颜色和样式
- 支持文本装饰
- 支持段落间距

### 5. Space 间距组件 (`/space/`)
提供统一的间距管理，替代手动使用 SizedBox。

**主要组件：**
- `ZephyrSpace` - 间距组件
- `ZephyrHSpace` - 水平间距组件
- `ZephyrVSpace` - 垂直间距组件
- `ZephyrSpaceDivider` - 分隔线组件
- `ZephyrSpaceUtils` - 间距工具类

**特性：**
- 支持水平和垂直间距
- 支持多种预设大小
- 支持换行布局
- 支持自定义间距
- 提供分隔线功能

## 使用方法

### 导入组件
```dart
import 'package:zephyr_ui/zephyr_ui.dart';
```

### Image 组件示例
```dart
// 网络图片
ZephyrNetworkImage(
  url: 'https://example.com/image.jpg',
  width: 100,
  height: 100,
  shape: ZephyrImageShape.rounded,
  borderRadius: 8,
)

// 头像图片
ZephyrAvatarImage(
  name: '张三',
  size: 60,
)
```

### Dropdown 组件示例
```dart
// 单选下拉菜单
ZephyrDropdown<String>(
  items: items,
  value: selectedValue,
  hintText: '请选择',
  onChanged: (value) {
    print('选择了: $value');
  },
)

// 多选下拉菜单
ZephyrMultiSelectDropdown<String>(
  items: items,
  values: selectedValues,
  hintText: '请选择多个',
  onChanged: (values) {
    print('选择了: $values');
  },
)
```

### Tag 组件示例
```dart
// 基础标签
ZephyrTag(
  text: '标签',
  style: ZephyrTagStyle.success,
)

// 可关闭标签
ZephyrCloseableTag(
  text: '可关闭标签',
  onClose: () {
    print('标签已关闭');
  },
)
```

### Typography 组件示例
```dart
// 标题
ZephyrTitle(text: '主标题')

// 段落
ZephyrParagraph(
  text: '这是一段正文内容',
)

// 链接
ZephyrLink(
  text: '点击这里',
  onTap: () {
    print('点击了链接');
  },
)
```

### Space 组件示例
```dart
// 水平间距
ZephyrSpace(
  direction: ZephyrSpaceDirection.horizontal,
  children: [
    Container(child: Text('项目1')),
    Container(child: Text('项目2')),
  ],
)

// 垂直间距
ZephyrSpace(
  direction: ZephyrSpaceDirection.vertical,
  children: [
    Container(child: Text('项目1')),
    Container(child: Text('项目2')),
  ],
)
```

## 设计原则

所有组件都遵循以下设计原则：

1. **一致性** - 统一的设计风格和交互模式
2. **可定制性** - 支持自定义样式和行为
3. **易用性** - 简单直观的 API 设计
4. **可访问性** - 支持辅助功能
5. **性能优化** - 高效的渲染和内存管理

## 注意事项

- 所有组件都支持主题定制
- 建议使用预设的样式和大小
- 注意组件的层级关系和命名规范
- 遵循 Ant Design 的设计规范