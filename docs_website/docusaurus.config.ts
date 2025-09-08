import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'chroma UI',
  tagline: 'A high-performance, elegant Flutter UI component library.',
  favicon: 'img/favicon.ico', // TODO: Replace with actual project favicon

  future: {
    v4: true,
  },

  // Set the production url of your site here
  url: 'https://your-org.github.io', // TODO: Change to your site's URL
  // Set the /<baseUrl>/ pathname under which your site is served
  baseUrl: '/flutter-ui/', // TODO: Change to your repo name

  organizationName: 'your-org', // Usually your GitHub org/user name.
  projectName: 'flutter-ui', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  i18n: {
    defaultLocale: 'zh-Hans',
    locales: ['zh-Hans'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          // Change this to your repo.
          editUrl:
            'https://github.com/your-org/flutter-ui/tree/main/docs_website/',
        },
        blog: false, // Disable the blog plugin
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    // Replace with your project's social card
    image: 'img/docusaurus-social-card.jpg', // TODO: Replace with actual social card
    navbar: {
      title: 'chroma UI',
      logo: {
        alt: 'chroma UI Logo',
        src: 'img/logo.svg', // TODO: Replace with actual logo
      },
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'tutorialSidebar',
          position: 'left',
          label: 'Components',
        },
        // {to: '/blog', label: 'Blog', position: 'left'}, // Blog disabled for now
        {
          href: 'https://github.com/your-org/flutter-ui', // TODO: Change to your repo URL
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Components',
              to: '/docs/intro',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'Stack Overflow',
              href: 'https://stackoverflow.com/questions/tagged/flutter',
            },
            {
              label: 'Discord',
              href: 'https://discordapp.com/invite/flutter',
            },
            {
              label: 'X',
              href: 'https://x.com/flutterdev',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/your-org/flutter-ui', // TODO: Change to your repo URL
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} chroma UI. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['dart'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
