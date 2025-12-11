import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "VelocityUI",
  description: "A high-performance Flutter UI component library",
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Components', link: '/zh-CN/components/basic/button' },
    ],
    sidebar: [
      {
        text: '基础组件',
        items: [
          { text: 'Button 按钮', link: '/zh-CN/components/basic/button' },
          { text: 'Text 文本', link: '/zh-CN/components/basic/text' },
          { text: 'Icon 图标', link: '/zh-CN/components/basic/icon' },
          { text: 'Image 图片', link: '/zh-CN/components/basic/image' },
          { text: 'Link 链接', link: '/zh-CN/components/basic/link' },
          { text: 'Chip 芯片', link: '/zh-CN/components/basic/chip' },
          { text: 'Spinner 加载动画', link: '/zh-CN/components/basic/spinner' },
        ],
      },
      {
        text: '展示组件',
        items: [
          { text: 'Avatar 头像', link: '/zh-CN/components/display/avatar' },
          { text: 'Badge 徽章', link: '/zh-CN/components/display/badge' },
          { text: 'Card 卡片', link: '/zh-CN/components/display/card' },
          { text: 'Carousel 轮播图', link: '/zh-CN/components/display/carousel' },
          { text: 'Collapse 折叠面板', link: '/zh-CN/components/display/collapse' },
          { text: 'List 列表', link: '/zh-CN/components/display/list' },
          { text: 'Tag 标签', link: '/zh-CN/components/display/tag' },
          { text: 'Timeline 时间线', link: '/zh-CN/components/display/timeline' },
          { text: 'Statistic 统计数值', link: '/zh-CN/components/display/statistic' },
          { text: 'Table 表格', link: '/zh-CN/components/display/table' },
          { text: 'Tooltip 文字提示', link: '/zh-CN/components/display/tooltip' },
          { text: 'Empty 空状态', link: '/zh-CN/components/display/empty' },
        ],
      },
      {
        text: '布局组件',
        items: [
          { text: 'Container 容器', link: '/zh-CN/components/layout/container' },
          { text: 'Grid 网格', link: '/zh-CN/components/layout/grid' },
          { text: 'Divider 分隔线', link: '/zh-CN/components/layout/divider' },
          { text: 'Stack 层叠', link: '/zh-CN/components/layout/stack' },
          { text: 'Scroll 滚动', link: '/zh-CN/components/layout/scroll' },
          { text: 'Space 间距', link: '/zh-CN/components/layout/space' },
          { text: 'SafeArea 安全区域', link: '/zh-CN/components/layout/safe_area' },
          { text: 'AspectRatio 宽高比', link: '/zh-CN/components/layout/aspect_ratio' },
        ],
      },
      {
        text: '导航组件',
        items: [
          { text: 'Navbar 导航栏', link: '/zh-CN/components/navigation/navbar' },
          { text: 'Tabs 标签页', link: '/zh-CN/components/navigation/tabs' },
          { text: 'Drawer 抽屉', link: '/zh-CN/components/navigation/drawer' },
          { text: 'Stepper 步骤条', link: '/zh-CN/components/navigation/stepper' },
          { text: 'BottomSheet 底部面板', link: '/zh-CN/components/navigation/bottom_sheet' },
          { text: 'Menu 菜单', link: '/zh-CN/components/navigation/menu' },
          { text: 'Pagination 分页', link: '/zh-CN/components/navigation/pagination' },
          { text: 'Segmented 分段器', link: '/zh-CN/components/navigation/segmented' },
        ],
      },
      {
        text: '表单组件',
        items: [
          { text: 'Input 输入框', link: '/zh-CN/components/form/input' },
          { text: 'Search 搜索框', link: '/zh-CN/components/form/search' },
          { text: 'Counter 计数器', link: '/zh-CN/components/form/counter' },
          { text: 'Select 选择器', link: '/zh-CN/components/form/select' },
          { text: 'Checkbox 复选框', link: '/zh-CN/components/form/checkbox' },
          { text: 'Radio 单选框', link: '/zh-CN/components/form/radio' },
          { text: 'Switch 开关', link: '/zh-CN/components/form/switch' },
          { text: 'Slider 滑块', link: '/zh-CN/components/form/slider' },
          { text: 'Rate 评分', link: '/zh-CN/components/form/rate' },
          { text: 'FormField 表单字段', link: '/zh-CN/components/form/form_field' },
        ],
      },
      {
        text: '反馈组件',
        items: [
          { text: 'Notification 通知', link: '/zh-CN/components/feedback/notification' },
          { text: 'Dialog 对话框', link: '/zh-CN/components/feedback/dialog' },
          { text: 'Toast 轻提示', link: '/zh-CN/components/feedback/toast' },
          { text: 'ActionSheet 动作面板', link: '/zh-CN/components/feedback/action_sheet' },
          { text: 'Popconfirm 气泡确认', link: '/zh-CN/components/feedback/popconfirm' },
          { text: 'Loading 加载', link: '/zh-CN/components/feedback/loading' },
          { text: 'Progress 进度条', link: '/zh-CN/components/feedback/progress' },
          { text: 'Result 结果页', link: '/zh-CN/components/feedback/result' },
          { text: 'Skeleton 骨架屏', link: '/zh-CN/components/feedback/skeleton' },
        ],
      },
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/your-repo/velocity_ui' }
    ]
  }
})
