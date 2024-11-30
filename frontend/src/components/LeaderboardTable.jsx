import React from 'react';
import './LeaderboardTable.css';

const formatPlaytime = (seconds) => {
  const h = Math.floor(seconds / 3600);
  const m = Math.floor((seconds % 3600) / 60);
  const s = Math.floor(seconds % 60);
  return `${h}h ${m}m ${s}s`;
};

const LeaderboardTable = ({ data }) => (
  <table className="leaderboard-table">
    <thead>
      <tr>
        <th>Name</th>
        <th>Auth</th>
        <th>Points</th>
        <th>Playtime</th>
        <th>Last Login</th>
      </tr>
    </thead>
    <tbody>
      {data.map((row, index) => (
        <tr key={index}>
          <td>{row.name.Valid ? row.name.String : 'Unknown'}</td>
          <td>{row.auth}</td>
          <td>{row.points.toFixed(2)}</td>
          <td>{formatPlaytime(row.playtime)}</td>
          <td>{new Date(parseInt(row.lastlogin) * 1000).toLocaleString()}</td>
        </tr>
      ))}
    </tbody>
  </table>
);

export default LeaderboardTable;
