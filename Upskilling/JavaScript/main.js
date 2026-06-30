// 1. Basics & Setup
console.log("Welcome to the Community Portal");
window.onload = () => alert("Page fully loaded");

// 2. Syntax, Data Types, and Operators
const eventName = "Community Festival";
const eventDate = "2026-08-01";
let seats = 100;
console.log(`Event: ${eventName} on ${eventDate}`);

function registerSeat() {
    seats--; // -- operator
    console.log(`Seats remaining: ${seats}`);
}

// 5. Objects and Prototypes
class Event {
    constructor(id, name, date, category, status) {
        this.id = id;
        this.name = name;
        this.date = date;
        this.category = category;
        this.status = status; // upcoming, past
    }
    checkAvailability() {
        return true;
    }
}

// 6. Arrays and Methods
let events = [
    new Event(1, "Tech Meetup", "2026-07-01", "tech", "upcoming"),
    new Event(2, "Concert", "2026-07-05", "music", "upcoming"),
    new Event(3, "Past Workshop", "2025-01-01", "tech", "past")
];

events.push(new Event(4, "Workshop on Baking", "2026-07-10", "food", "upcoming"));
console.log("Music events:", events.filter(e => e.category === 'music'));
console.log("Display formats:", events.map(e => `${e.name} - ${e.date}`));

// 3. Conditionals, Loops, and Error Handling
try {
    events.forEach(e => {
        if (e.status === 'upcoming') {
            console.log("Valid Event:", e.name);
        } else {
            console.log("Hidden Event:", e.name);
        }
    });
} catch(err) {
    console.error("Error processing events", err);
}

// 4. Functions, Scope, Closures
function addEvent(e) { events.push(e); }
function filterEventsByCategory(cat) {
    return events.filter(e => e.category === cat);
}
const createRegistrationTracker = () => {
    let registrations = 0;
    return () => {
        registrations++;
        return registrations;
    }
};
const registerUser = createRegistrationTracker();

// 7. DOM Manipulation
const container = document.querySelector("#eventsContainer");
function renderEvents(eventList) {
    container.innerHTML = "";
    eventList.forEach(e => {
        if(e.status === 'upcoming') {
            const card = document.createElement("div");
            card.className = "eventCard";
            card.innerHTML = `<h3>${e.name}</h3><p>${e.date}</p><button class="reg-btn">Register</button>`;
            container.appendChild(card);
        }
    });
}
renderEvents(events);

// 8. Event Handling
document.querySelector("#categoryFilter").onchange = (e) => {
    const val = e.target.value;
    const filtered = val === 'all' ? events : filterEventsByCategory(val);
    renderEvents(filtered);
};
document.querySelector("#searchInput").addEventListener("keydown", (e) => {
    setTimeout(() => { // wait for keypress to register
        const term = e.target.value.toLowerCase();
        // 10. Modern JS Features - spread operator and destructuring
        const clonedEvents = [...events];
        const filtered = clonedEvents.filter(({name}) => name.toLowerCase().includes(term));
        renderEvents(filtered);
    }, 50);
});

// 9. Async JS
async function fetchEvents() {
    try {
        // mock endpoint
        const response = await fetch("https://jsonplaceholder.typicode.com/posts/1");
        const data = await response.json();
        console.log("Fetched async event data:", data);
    } catch (err) {
        console.error("Failed to fetch", err);
    }
}
fetchEvents();

// 11. Working with Forms & 12. AJAX
const form = document.querySelector("#regForm");
form.onsubmit = (e) => {
    e.preventDefault(); // Prevent default behavior
    const { userName, userEmail } = form.elements;
    if(!userName.value || !userEmail.value) {
        document.querySelector("#formMsg").textContent = "Errors inline";
        return;
    }
    document.querySelector("#formMsg").textContent = "Submitting...";
    
    // fetch POST mock
    fetch("https://jsonplaceholder.typicode.com/posts", {
        method: "POST",
        body: JSON.stringify({ name: userName.value, email: userEmail.value })
    })
    .then(r => r.json())
    .then(data => {
        setTimeout(() => {
            document.querySelector("#formMsg").textContent = "Success!";
            registerUser(); // track closures
        }, 1000);
    })
    .catch(err => {
        document.querySelector("#formMsg").textContent = "Failure!";
    });
};

// 14. jQuery and JS Frameworks
// Benefit of React/Vue: Component-based architecture, reactive state, virtual DOM
$(document).ready(function(){
    $(document).on("click", ".reg-btn", function() {
        alert("jQuery Click Handled!");
        $(this).parent().fadeOut().fadeIn();
    });
});
