import React from 'react';
import { Link } from 'react-router-dom';
import './SideNav.css'; // Component-specific styles

const SideNav = () => (
  <aside className="side-nav">
    <ul>
      <li><Link to="/latest/wr">最新记录</Link></li>
      <li><Link to="/latest/completion">最新完成</Link></li>
      <li><Link to="/top/player/point">玩家排名</Link></li>
    </ul>
  </aside>
);

export default SideNav;
