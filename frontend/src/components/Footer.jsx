import React from 'react';
import './Footer.css'; // Component-specific styles

const Footer = () => (
  <footer className="footer">
    <p>
      &copy; {new Date().getFullYear()}{' '}
      <a href="https://www.cialloo.com" target="_blank" rel="noopener noreferrer" className="footer-link">
        Cialloo
      </a>
      . All rights reserved.
    </p>
  </footer>
);

export default Footer;
