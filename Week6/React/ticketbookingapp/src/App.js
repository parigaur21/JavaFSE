import React, { useState } from 'react';
function App() {
    const [loggedIn, setLoggedIn] = useState(false);
    return (
        <div>
            {loggedIn ? (
                <div>
                    <h1>User Page - Book Tickets</h1>
                    <button onClick={() => setLoggedIn(false)}>Logout</button>
                </div>
            ) : (
                <div>
                    <h1>Guest Page - Flight Details</h1>
                    <button onClick={() => setLoggedIn(true)}>Login</button>
                </div>
            )}
        </div>
    );
}
export default App;
