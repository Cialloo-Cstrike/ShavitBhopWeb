import React from 'react';
import './LatestCompletionTable.css';

// Function to map track numbers
const trackMapping = (track) => {
    if (track === 0) {
        return 'Main';
    }
    return `Bonus ${track}`;
};

// Mapping styles
const styleMapping = {
    0: 'Normal',
    1: 'Sideways',
    2: 'W-Only',
    3: 'Scroll',
    4: '400 Velocity',
    5: 'Half-Sideways',
    6: 'A/D-Only',
    7: 'Segmented',
    8: 'Low Gravity',
    9: 'Slow Motion',
    10: 'TAS',
    11: 'Scroll Kz',
};

// Format seconds as human-readable date
const formatSeconds = (seconds) => {
    const date = new Date(seconds * 1000);
    return date.toLocaleString();
};

// Format time as "X min Y seconds"
const formatTime = (time) => {
    const mins = Math.floor(time / 60);
    const secs = (time % 60).toFixed(2);
    return `${mins}m ${secs}s`;
};

const LatestCompletionTable = ({ data }) => (
    <div className="LatestCompletionTableContainer">
        <table className="LatestCompletionTable">
            <thead>
                <tr>
                    <th>Map</th>
                    <th>Name</th>
                    <th>Style</th>
                    <th>Track</th>
                    <th>Min Time</th>
                    <th>Date</th>
                    <th>Jumps</th>
                    <th>Sync</th>
                    <th>Strafes</th>
                    <th>Perfs</th>
                </tr>
            </thead>
            <tbody>
                {data.map((row, index) => (
                    <tr key={index}>
                        <td>{row.map}</td>
                        <td>{row.name.Valid ? row.name.String : 'Unknown'}</td>
                        <td>{styleMapping[row.style] || 'Unknown'}</td>
                        <td>{trackMapping(row.track)}</td>
                        <td>{formatTime(row.time)}</td>
                        <td>{row.date.Valid ? formatSeconds(row.date.Int32) : 'N/A'}</td>
                        <td>{row.jumps.Valid ? row.jumps.Int32 : 'N/A'}</td>
                        <td>{row.sync.Valid ? row.sync.Float64.toFixed(2) : 'N/A'}</td>
                        <td>{row.strafes.Valid ? row.strafes.Int32 : 'N/A'}</td>
                        <td>{row.perfs.Valid ? row.perfs.Float64.toFixed(2) : 'N/A'}</td>
                    </tr>
                ))}
            </tbody>
        </table>
    </div>
);

export default LatestCompletionTable;
