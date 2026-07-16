import React, { useState } from 'react';
export default function CurrencyConvertor() {
    const [euro, setEuro] = useState(0);
    const [inr, setInr] = useState(0);
    const handleSubmit = (e) => {
        e.preventDefault();
        setInr(euro * 90);
    };
    return (
        <form onSubmit={handleSubmit}>
            <h3>Convert Euro to INR</h3>
            <input type="number" value={euro} onChange={e => setEuro(e.target.value)} />
            <button type="submit">Convert</button>
            <p>INR: {inr}</p>
        </form>
    );
}
