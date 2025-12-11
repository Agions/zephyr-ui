import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "VelocityUI",
  description: "A high-performance Flutter UI component library",
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Components', link: '/components/basic/button' },
    ],
    sidebar: [
      {
        text: '基础组件',
        items: [
          { text: 'Button 按钮', link: '/components/basic/button' },
          { text: 'Text 文本', link: '/components/basic/text' },
          { text: 'Icon 图标', link: '/components/basic/icon' },
          { text: 'Image 图片', link: '/components/basic/image' },
          { text: 'Link 链接', link: '/components/basic/link' },
          { text: 'Chip 芯片', link: '/components/basic/chip' },
          { text: 'Spinner 加载动画', link: '/components/basic/spinner' },
        ],
      },
      {
        text: '展示组件',
        items: [
          { text: 'Avatar 头像', link: '/components/display/avatar' },
          { text: 'Badge 徽章', link: '/components/display/badge' },
          { text: 'Card 卡片', link: '/components/display/card' },
          { text: 'Carousel 轮播图', link: '/components/display/carousel' },
          { text: 'Collapse 折叠面板', link: '/components/display/collapse' },
          { text: 'List 列表', link: '/components/display/list' },
          { text: 'Tag 标签', link: '/components/display/tag' },
          { text: 'Timeline 时间线', link: '/components/display/timeline' },
          { text: 'Statistic 统计数值', link: '/components/display/statistic' },
          { text: 'Table 表格', link: '/components/display/table' },
          { text: 'Tooltip 文字提示', link: '/components/display/tooltip' },
          { text: 'Empty 空状态', link: '/components/display/empty' },
        ],
      },
      {
        text: '布局组件',
        items: [
          { text: 'Container 容器', link: '/components/layout/container' },
          { text: 'Grid 网格', link: '/components/layout/grid' },
          { text: 'Divider 分隔线', link: '/components/layout/divider' },
          { text: 'Stack 层叠', link: '/components/layout/stack' },
          { text: 'Scroll 滚动', link: '/components/layout/scroll' },
          { text: 'Space 间距', link: '/components/layout/space' },
          { text: 'SafeArea 安全区域', link: '/components/layout/safe_area' },
          { text: 'AspectRatio 宽高比', link: '/components/layout/aspect_ratio' },
        ],
      },
      {
        text: '导航组件',
        items: [
          { text: 'Navbar 导航栏', link: '/components/navigation/navbar' },
          { text: 'Tabs 标签页', link: '/components/navigation/tabs' },
          { text: 'Drawer 抽屉', link: '/components/navigation/drawer' },
          { text: 'Stepper 步骤条', link: '/components/navigation/stepper' },
          { text: 'BottomSheet 底部面板', link: '/components/navigation/bottom_sheet' },
          { text: 'Menu 菜单', link: '/components/navigation/menu' },
          { text: 'Pagination 分页', link: '/components/navigation/pagination' },
          { text: 'Segmented 分段器', link: '/components/navigation/segmented' },
          { text: 'Breadcrumb 面包屑', link: '/components/navigation/breadcrumb' },
        ],
      },
      {
        text: '表单组件',
        items: [
          { text: 'Input 输入框', link: '/components/form/input' },
          { text: 'Search 搜索框', link: '/components/form/search' },
          { text: 'Counter 计数器', link: '/components/form/counter' },
          { text: 'Select 选择器', link: '/components/form/select' },
          { text: 'Checkbox 复选框', link: '/components/form/checkbox' },
          { text: 'Radio 单选框', link: '/components/form/radio' },
          { text: 'Switch 开关', link: '/components/form/switch' },
          { text: 'Slider 滑块', link: '/components/form/slider' },
          { text: 'Rate 评分', link: '/components/form/rate' },
          { text: 'DatePicker 日期选择器', link: '/components/form/date_picker' },
          { text: 'Upload 上传', link: '/components/form/upload' },
          { text: 'FormField 表单字段', link: '/components/form/form_field' },
        ],
      },
      {
        text: '反馈组件',
        items: [
          { text: 'Notification 通知', link: '/components/feedback/notification' },
          { text: 'Dialog 对话框', link: '/components/feedback/dialog' },
          { text: 'Toast 轻提示', link: '/components/feedback/toast' },
          { text: 'ActionSheet 动作面板', link: '/components/feedback/action_sheet' },
          { text: 'Popconfirm 气泡确认', link: '/components/feedback/popconfirm' },
          { text: 'Loading 加载', link: '/components/feedback/loading' },
          { text: 'Progress 进度条', link: '/components/feedback/progress' },
          { text: 'Result 结果页', link: '/components/feedback/result' },
          { text: 'Skeleton 骨架屏', link: '/components/feedback/skeleton' },
        ],
      },
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/agions/velocity_ui' }
    ]
  }
})
