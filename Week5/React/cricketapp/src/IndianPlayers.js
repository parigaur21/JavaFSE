import React from 'react';
export default function IndianPlayers() {
    const T20players = ['Player A', 'Player B'];
    const RanjiTrophy = ['Player C', 'Player D'];
    const merged = [...T20players, ...RanjiTrophy];
    const [odd, even] = merged;
    return (
        <div>
            <h3>Odd: {odd}</h3>
            <h3>Even: {even}</h3>
            <h3>Merged: {merged.join(', ')}</h3>
        </div>
    );
}
