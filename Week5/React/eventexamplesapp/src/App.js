import React, { useState } from 'react';
import CurrencyConvertor from './CurrencyConvertor';
function App() {
    const [count, setCount] = useState(0);
    const handleIncrease = () => {
        setCount(count + 1);
        console.log('Hello, static message!');
    };
    const sayWelcome = (msg) => alert(msg);
    const onPress = (e) => alert('I was clicked');
    return (
        <div>
            <button onClick={handleIncrease}>Increment</button>
            <button onClick={() => setCount(count - 1)}>Decrement</button>
            <p>Count: {count}</p>
            <button onClick={() => sayWelcome('welcome')}>Say Welcome</button>
            <button onClick={onPress}>OnPress</button>
            <CurrencyConvertor />
        </div>
    );
}
export default App;
