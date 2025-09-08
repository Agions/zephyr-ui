import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: '🎨 Design Token System',
    Svg: require('@site/static/img/design-tokens.svg').default,
    description: (
      <>
        Comprehensive design token system with colors, typography, spacing, and more. 
        Build consistent, scalable interfaces that match your brand perfectly.
      </>
    ),
  },
  {
    title: '📱 Mobile-First Components',
    Svg: require('@site/static/img/mobile-components.svg').default,
    description: (
      <>
        60+ professional components optimized for mobile with touch-friendly interactions, 
        smooth animations, and platform-specific behaviors for iOS and Android.
      </>
    ),
  },
  {
    title: '⚡ Performance Optimized',
    Svg: require('@site/static/img/performance.svg').default,
    description: (
      <>
        Virtual scrolling, lazy loading, 60fps animations, and comprehensive performance 
        monitoring. Built for enterprise-scale applications with millions of users.
      </>
    ),
  },
  {
    title: '🌐 Responsive Design',
    Svg: require('@site/static/img/responsive.svg').default,
    description: (
      <>
        Advanced responsive layout system with breakpoint management, adaptive components, 
        and automatic scaling across mobile, tablet, and desktop devices.
      </>
    ),
  },
  {
    title: '♿ Accessibility First',
    Svg: require('@site/static/img/accessibility.svg').default,
    description: (
      <>
        Full WCAG 2.1 AA compliance with screen reader support, keyboard navigation, 
        semantic labels, and high contrast mode support built into every component.
      </>
    ),
  },
  {
    title: '🛠️ Developer Experience',
    Svg: require('@site/static/img/developer-experience.svg').default,
    description: (
      <>
        Type-safe APIs, comprehensive documentation, interactive examples, testing utilities, 
        and powerful CLI tools for maximum developer productivity.
      </>
    ),
  },
];

function Feature({title, Svg, description}: {
  title: string;
  Svg: React.ComponentType<React.ComponentProps<'svg'>>;
  description: JSX.Element;
}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures(): JSX.Element {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}