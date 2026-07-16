import React from 'react';
function App() {
    const offices = [
        { name: 'Office 1', rent: 50000, address: 'Address 1', image: 'https://via.placeholder.com/150' },
        { name: 'Office 2', rent: 70000, address: 'Address 2', image: 'https://via.placeholder.com/150' }
    ];
    return (
        <div>
            <h1>Office Space Rental</h1>
            {offices.map((o, i) => (
                <div key={i} style={{ border: '1px solid black', margin: '10px', padding: '10px' }}>
                    <img src={o.image} alt={o.name} />
                    <h2>{o.name}</h2>
                    <p style={{ color: o.rent < 60000 ? 'red' : 'green' }}>Rent: {o.rent}</p>
                    <p>Address: {o.address}</p>
                </div>
            ))}
        </div>
    );
}
export default App;
