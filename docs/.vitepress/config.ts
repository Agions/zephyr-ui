import { defineConfig } from 'vitepress'
import { resolve } from 'path'

// 站点配置
export default defineConfig({
  // 站点基础配置
  lang: 'zh-CN',
  title: 'ZephyrUI',
  description: '企业级 Flutter UI 组件库',
  
  // 站点基础路径
  base: '/',
  
  // SEO 配置
  head: [
    ['meta', { name: 'keywords', content: 'Flutter, UI, 组件库, ZephyrUI, 企业级, 响应式设计, 国际化' }],
    ['meta', { name: 'author', content: 'Agions Team' }],
    ['meta', { name: 'viewport', content: 'width=device-width, initial-scale=1.0' }],
    ['link', { rel: 'icon', href: '/logo.png' }],
    ['link', { rel: 'preconnect', href: 'https://fonts.googleapis.com' }],
    ['link', { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous' }],
    ['link', { href: 'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap', rel: 'stylesheet' }],
  ],
  
  // 主题配置
  themeConfig: {
    // 站点 logo
    logo: '/logo.png',
    
    // 站点导航
    nav: [
      { text: '首页', link: '/' },
      { text: '组件', link: '/zh-CN/components/introduction' },
      { text: 'API 参考', link: '/zh-CN/api/introduction' },
      { text: '指南', link: '/zh-CN/guide/getting-started' },
      { text: '设计系统', link: '/zh-CN/design-system/color' },
      { 
        text: 'v0.4.0', 
        items: [
          { text: '更新日志', link: '/zh-CN/changelog' },
          { text: '贡献指南', link: '/zh-CN/guide/contributing' },
          { text: 'GitHub', link: 'https://github.com/Agions/zephyr-ui' }
        ] 
      }
    ],
    
    // 侧边栏配置
    sidebar: {
      '/zh-CN/': [
        {
          text: '开始',
          items: [
            { text: '快速开始', link: '/zh-CN/guide/getting-started' },
            { text: '安装指南', link: '/zh-CN/guide/installation' },
            { text: '项目结构', link: '/zh-CN/guide/project-structure' },
          ]
        },
        {
          text: '组件',
          items: [
            { text: '组件概览', link: '/zh-CN/components/introduction' },
            {
              text: '基础组件',
              items: [
                { text: '按钮', link: '/zh-CN/components/basic/button' },
                { text: '文本', link: '/zh-CN/components/basic/text' },
                { text: '图标', link: '/zh-CN/components/basic/icon' },
                { text: '头像', link: '/zh-CN/components/basic/avatar' },
                { text: '徽章', link: '/zh-CN/components/basic/badge' },
                { text: '卡片', link: '/zh-CN/components/basic/card' },
                { text: '分割线', link: '/zh-CN/components/basic/divider' },
                { text: '标签', link: '/zh-CN/components/basic/tag' },
                { text: '提示框', link: '/zh-CN/components/basic/tooltip' },
              ]
            },
            {
              text: '表单组件',
              items: [
                { text: '输入框', link: '/zh-CN/components/form/input' },
                { text: '选择器', link: '/zh-CN/components/form/select' },
                { text: '复选框', link: '/zh-CN/components/form/checkbox' },
                { text: '单选框', link: '/zh-CN/components/form/radio' },
                { text: '开关', link: '/zh-CN/components/form/switch' },
                { text: '滑块', link: '/zh-CN/components/form/slider' },
                { text: '评分', link: '/zh-CN/components/form/rating' },
                { text: '日期选择器', link: '/zh-CN/components/form/date-picker' },
                { text: '文本域', link: '/zh-CN/components/form/text-area' },
              ]
            },
            {
              text: '导航组件',
              items: [
                { text: '标签页', link: '/zh-CN/components/navigation/tabs' },
                { text: '底部导航栏', link: '/zh-CN/components/navigation/bottom-navigation-bar' },
                { text: '侧边菜单', link: '/zh-CN/components/navigation/side-menu' },
                { text: '步骤器', link: '/zh-CN/components/navigation/stepper' },
                { text: '分页器', link: '/zh-CN/components/navigation/pagination' },
                { text: '导航栏', link: '/zh-CN/components/navigation/navigation-rail' },
                { text: '树形控件', link: '/zh-CN/components/navigation/tree' },
              ]
            },
            {
              text: '展示组件',
              items: [
                { text: '列表', link: '/zh-CN/components/display/list' },
                { text: '表格', link: '/zh-CN/components/display/table' },
                { text: '日历', link: '/zh-CN/components/display/calendar' },
                { text: '时间线', link: '/zh-CN/components/display/timeline' },
                { text: '统计卡片', link: '/zh-CN/components/display/statistic' },
                { text: '头像组', link: '/zh-CN/components/display/avatar-group' },
                { text: '轮播图', link: '/zh-CN/components/display/carousel' },
                { text: '图表', link: '/zh-CN/components/display/charts' },
              ]
            },
            {
              text: '反馈组件',
              items: [
                { text: '警告框', link: '/zh-CN/components/feedback/alert' },
                { text: '模态框', link: '/zh-CN/components/feedback/modal' },
                { text: '提示框', link: '/zh-CN/components/feedback/toast' },
                { text: '进度条', link: '/zh-CN/components/feedback/progress' },
                { text: '骨架屏', link: '/zh-CN/components/feedback/skeleton' },
                { text: '通知', link: '/zh-CN/components/feedback/notification' },
              ]
            }
          ]
        },
        {
          text: 'API 参考',
          items: [
            { text: 'API 概览', link: '/zh-CN/api/introduction' },
            {
              text: '组件 API',
              items: [
                { text: 'ZephyrButton', link: '/zh-CN/api/components/zephyr-button' },
                { text: 'ZephyrInput', link: '/zh-CN/api/components/zephyr-input' },
                { text: 'ZephyrText', link: '/zh-CN/api/components/zephyr-text' },
                { text: 'ZephyrIcon', link: '/zh-CN/api/components/zephyr-icon' },
              ]
            },
            {
              text: '主题 API',
              items: [
                { text: 'ZephyrThemeData', link: '/zh-CN/api/theme/zephyr-theme-data' },
                { text: 'ZephyrButtonThemeData', link: '/zh-CN/api/theme/zephyr-button-theme-data' },
                { text: 'ZephyrInputThemeData', link: '/zh-CN/api/theme/zephyr-input-theme-data' },
              ]
            },
            {
              text: '工具类 API',
              items: [
                { text: 'ResponsiveBuilder', link: '/zh-CN/api/utils/responsive-builder' },
                { text: 'ZephyrValidator', link: '/zh-CN/api/utils/zephyr-validator' },
                { text: 'ZephyrLocalizations', link: '/zh-CN/api/utils/zephyr-localizations' },
              ]
            },
            {
              text: '类型定义',
              items: [
                { text: 'ZephyrVariant', link: '/zh-CN/api/types/zephyr-variant' },
                { text: 'ZephyrSize', link: '/zh-CN/api/types/zephyr-size' },
                { text: 'DeviceType', link: '/zh-CN/api/types/device-type' },
              ]
            }
          ]
        },
        {
          text: '设计系统',
          items: [
            { text: '设计原则', link: '/zh-CN/design-system/principles' },
            { text: '颜色系统', link: '/zh-CN/design-system/color' },
            { text: '字体系统', link: '/zh-CN/design-system/typography' },
            { text: '图标系统', link: '/zh-CN/design-system/icons' },
            { text: '间距系统', link: '/zh-CN/design-system/spacing' },
            { text: '动画系统', link: '/zh-CN/design-system/motion' },
          ]
        },
        {
          text: '开发者指南',
          items: [
            { text: '开发环境', link: '/zh-CN/guide/development-setup' },
            { text: '组件开发', link: '/zh-CN/guide/component-development' },
            { text: '主题定制', link: '/zh-CN/guide/theme-system' },
            { text: '响应式设计', link: '/zh-CN/guide/responsive-design' },
            { text: '国际化', link: '/zh-CN/guide/internationalization' },
            { text: '测试指南', link: '/zh-CN/guide/testing' },
            { text: '性能优化', link: '/zh-CN/guide/performance' },
            { text: '无障碍设计', link: '/zh-CN/guide/accessibility' },
            { text: '最佳实践', link: '/zh-CN/guide/best-practices' },
          ]
        },
        {
          text: '更多',
          items: [
            { text: '更新日志', link: '/zh-CN/changelog' },
            { text: '贡献指南', link: '/zh-CN/guide/contributing' },
            { text: '常见问题', link: '/zh-CN/guide/faq' },
            { text: '许可证', link: '/zh-CN/license' },
          ]
        }
      ]
    },
    
    // 社交链接
    socialLinks: [
      { icon: 'github', link: 'https://github.com/Agions/zephyr-ui' },
      { icon: 'twitter', link: 'https://twitter.com/Agions' },
    ],
    
    // 页脚配置
    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2024 Agions Team'
    },
    
    // 搜索配置
    search: {
      provider: 'local',
      options: {
        // 搜索详细程度
        detailedView: true,
        // 搜索结果数量
        pageSize: 10,
        // 搜索翻译
        translations: {
          button: {
            buttonText: '搜索文档',
            buttonAriaLabel: '搜索文档',
          },
          modal: {
            displayDetails: '显示详细列表',
            resetButtonTitle: '清除查询条件',
            backButtonTitle: '关闭搜索',
            noResultsText: '无法找到相关结果',
            footer: {
              selectText: '选择',
              navigateText: '切换',
              closeText: '关闭',
            },
          },
        },
        // 搜索排除的页面
        exclude: [
          '/zh-CN/changelog',
          '/zh-CN/license',
        ],
      },
    },
    
    // 编辑链接
    editLink: {
      pattern: 'https://github.com/Agions/zephyr-ui/edit/main/docs/:path',
      text: '在 GitHub 上编辑此页'
    },
    
    // 最后更新时间
    lastUpdated: {
      text: '最后更新于',
      formatOptions: {
        dateStyle: 'short',
        timeStyle: 'short'
      }
    },
    
    // 外部链接
    externalLinkIcon: true,
  },
  
  // Markdown 配置
  markdown: {
    // 代码块主题
    theme: 'github-dark',
    // 行号
    lineNumbers: true,
    // 代码块支持的语言
    languages: ['dart', 'javascript', 'typescript', 'json', 'yaml', 'bash'],
    // 自定义标记
    attrs: {
      // 支持在 markdown 中使用自定义属性
    },
  },
  
  // 构建配置
  build: {
    // 静态资源处理
    assetsInlineLimit: 4096,
    // 构建后的资源基础路径
    assetsDir: 'assets',
    // 构建时排除的文件
    rollupOptions: {
      external: [],
    },
  },
  
  // 插件配置
  vite: {
    plugins: [],
    resolve: {
      alias: {
        '@': resolve(__dirname, '..'),
      },
    },
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: `@import "@/styles/variables.scss";`,
        },
      },
    },
  },
  
  // 多语言配置
  locales: {
    root: {
      label: '简体中文',
      lang: 'zh-CN',
      link: '/zh-CN/',
    },
    en: {
      label: 'English',
      lang: 'en',
      link: '/en/',
    },
  },
})