import React from 'react';
export default function CalculateScore({ Name, School, Total, Goal }) {
    return (
        <div className="score-board">
            <h1>Student Details</h1>
            <p>Name: {Name}</p>
            <p>School: {School}</p>
            <p>Total: {Total}</p>
            <p>Goal: {Goal}</p>
            <p>Average Score: {Total / Goal}</p>
        </div>
    );
}