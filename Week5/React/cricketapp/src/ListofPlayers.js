import React from 'react';
export default function ListofPlayers() {
    const players = [
        { name: 'P1', score: 80 }, { name: 'P2', score: 60 }, { name: 'P3', score: 90 },
        { name: 'P4', score: 50 }, { name: 'P5', score: 75 }, { name: 'P6', score: 65 },
        { name: 'P7', score: 85 }, { name: 'P8', score: 40 }, { name: 'P9', score: 95 },
        { name: 'P10', score: 55 }, { name: 'P11', score: 100 }
    ];
    const below70 = players.filter(p => p.score < 70);
    return (
        <div>
            <h3>All Players</h3>
            <ul>{players.map((p, i) => <li key={i}>{p.name} - {p.score}</li>)}</ul>
            <h3>Players below 70</h3>
            <ul>{below70.map((p, i) => <li key={i}>{p.name} - {p.score}</li>)}</ul>
        </div>
    );
}
