import React from "react"
import clsx from "clsx"
import Link from "@docusaurus/Link"
import useDocusaurusContext from "@docusaurus/useDocusaurusContext"
import Layout from "@theme/Layout"
import HomepageFeatures from "@site/src/components/HomepageFeatures"

import styles from "./index.module.css"

function HomepageHeader() {
  const { siteConfig } = useDocusaurusContext()
  return (
    <header className={clsx("hero hero--primary", styles.heroBanner)}>
      <div className='container'>
        <h1 className='hero__title'>{siteConfig.title}</h1>
        <p className='hero__subtitle'>{siteConfig.tagline}</p>
        <div className={styles.buttons}>
          <Link
            className='button button--secondary button--lg'
            to='/docs/intro'
          >
            Get Started
          </Link>
          <Link className='button button--outline button--lg' to='/storybook'>
            View Components
          </Link>
        </div>
      </div>
    </header>
  )
}

export default function Home(): JSX.Element {
  const { siteConfig } = useDocusaurusContext()
  return (
    <Layout
      title={`${siteConfig.title}`}
      description='Enterprise Flutter UI Framework with Comprehensive Design Tokens'
    >
      <HomepageHeader />
      <main>
        <HomepageFeatures />
        <div className={styles.featuresSection}>
          <div className='container'>
            <div className='row'>
              <div className={clsx("col col--4")}>
                <div className={styles.featureCard}>
                  <h3>🎨 Design Tokens</h3>
                  <p>
                    Comprehensive design token system with colors, typography,
                    spacing, and more. Build consistent UIs with semantic
                    naming.
                  </p>
                </div>
              </div>
              <div className={clsx("col col--4")}>
                <div className={styles.featureCard}>
                  <h3>📱 Mobile First</h3>
                  <p>
                    Every component is optimized for mobile with touch-friendly
                    interactions, proper sizing, and platform-specific
                    behaviors.
                  </p>
                </div>
              </div>
              <div className={clsx("col col--4")}>
                <div className={styles.featureCard}>
                  <h3>♿ Accessibility</h3>
                  <p>
                    Full WCAG 2.1 AA compliance with screen reader support,
                    keyboard navigation, and semantic HTML.
                  </p>
                </div>
              </div>
            </div>
            <div className='row'>
              <div className={clsx("col col--4")}>
                <div className={styles.featureCard}>
                  <h3>⚡ Performance</h3>
                  <p>
                    Virtual scrolling, lazy loading, and 60fps animations. Built
                    for enterprise-scale applications.
                  </p>
                </div>
              </div>
              <div className={clsx("col col--4")}>
                <div className={styles.featureCard}>
                  <h3>🧪 Testing</h3>
                  <p>
                    90%+ test coverage with unit, widget, integration, and
                    performance tests. Golden tests for visual regression.
                  </p>
                </div>
              </div>
              <div className={clsx("col col--4")}>
                <div className={styles.featureCard}>
                  <h3>🌍 Internationalization</h3>
                  <p>
                    Built-in i18n support with multiple language packs. RTL
                    support for Arabic and Hebrew.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className={styles.codeExampleSection}>
          <div className='container'>
            <h2>Quick Example</h2>
            <div className={styles.codeBlock}>
              <pre>
                {`import 'package:zephyr_ui/zephyr_ui.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      
      home: Scaffold(
        appBar: AppBar(title: Text('Zephyr UI Demo')),
        body: Center(
          child: ZephyrUIButton.primary(
            text: 'Get Started',
            onPressed: () => print('Button pressed!'),
          ),
        ),
      ),
    );
  }
}`}
              </pre>
            </div>
          </div>
        </div>

        <div className={styles.ctaSection}>
          <div className='container'>
            <h2>Ready to Build Beautiful Apps?</h2>
            <p>Join thousands of developers using Zephyr UI Design System</p>
            <div className={styles.ctaButtons}>
              <Link
                className='button button--primary button--lg'
                to='/docs/installation'
              >
                Install Now
              </Link>
              <Link
                className='button button--outline button--lg'
                to='https://github.com/agions/zephyr-ui'
              >
                View on GitHub
              </Link>
            </div>
          </div>
        </div>
      </main>
    </Layout>
  )
}
