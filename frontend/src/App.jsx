import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Header from './components/Header';
import SideNav from './components/SideNav';
import Footer from './components/Footer';
import About from './pages/About';
import './App.css'; // Main app styles
import Leaderboard from './pages/Leaderboard';
import LatestWrPage from './pages/LatestWrPage';
import LatestCompletionPage from './pages/LatestCompletionPage';

const App = () => (
  <div className="app-container">
    <Header />
    <div className="content">
      <SideNav />
      <main>
        <Routes>
          <Route path="/" element={<About />} />
          <Route path="/about" element={<About />} />
          <Route path="/top/player/point" element={<Leaderboard />} />
          <Route path="/latest/wr" element={<LatestWrPage />} />
          <Route path="/latest/completion" element={<LatestCompletionPage />} />
        </Routes>
      </main>
    </div>
    <Footer />
  </div>
);

export default App;
