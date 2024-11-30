import React from 'react';
import './About.css'; // Page-specific styles

const About = () => (
  <div className="about-container">
    <h2 className="about-title">关于我们</h2>
    <p className="about-content">
      我们致力于提供高质量的 CS起源 和 CS2 的 Bhop 和 KZ 模式游戏服务器。欢迎大家加入我们的社区！
    </p>
    <ul className="about-server-list">
      <li>CS2 KZ: 42.194.148.31:27016</li>
      <li>CS起源 Bhop: 124.223.33.163:27015</li>
      <li>CS起源 Bhop: 124.223.33.163:27016</li>
      <li>CS起源 KZ: 124.223.33.163:27017</li>
      <li>CS起源 KZ: 124.223.33.163:27018</li>
    </ul>
    <p className="about-content">
      欢迎加入我们的 QQ 群：滑翔 Kz 连跳公共 QQ 群 <strong>876102474</strong>
    </p>
    <p className="about-content">
      如果您愿意支持我们的服务器维护和升级，请访问 <a href="https://www.cialloo.com/donate" target="_blank" rel="noopener noreferrer">www.cialloo.com/donate</a> 为我充电!
    </p>
  </div>
);

export default About;
