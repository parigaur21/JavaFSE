
console.log("Welcome to the Community Portal");
window.onload = () => alert("Page fully loaded");


const eventName = "Community Festival";
const eventDate = "2026-08-01";
let seats = 100;
console.log(`Event: ${eventName} on ${eventDate}`);

function registerSeat() {
    seats--; 
    console.log(`Seats remaining: ${seats}`);
}


class Event {
    constructor(id, name, date, category, status) {
        this.id = id;
        this.name = name;
        this.date = date;
        this.category = category;
        this.status = status; 
    }
    checkAvailability() {
        return true;
    }
}


let events = [
    new Event(1, "Tech Meetup", "2026-07-01", "tech", "upcoming"),
    new Event(2, "Concert", "2026-07-05", "music", "upcoming"),
    new Event(3, "Past Workshop", "2025-01-01", "tech", "past")
];

events.push(new Event(4, "Workshop on Baking", "2026-07-10", "food", "upcoming"));
console.log("Music events:", events.filter(e => e.category === 'music'));
console.log("Display formats:", events.map(e => `${e.name} - ${e.date}`));


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


document.querySelector("#categoryFilter").onchange = (e) => {
    const val = e.target.value;
    const filtered = val === 'all' ? events : filterEventsByCategory(val);
    renderEvents(filtered);
};
document.querySelector("#searchInput").addEventListener("keydown", (e) => {
    setTimeout(() => { 
        const term = e.target.value.toLowerCase();
        
        const clonedEvents = [...events];
        const filtered = clonedEvents.filter(({name}) => name.toLowerCase().includes(term));
        renderEvents(filtered);
    }, 50);
});


async function fetchEvents() {
    try {
        
        const response = await fetch("https://jsonplaceholder.typicode.com/posts/1");
        const data = await response.json();
        console.log("Fetched async event data:", data);
    } catch (err) {
        console.error("Failed to fetch", err);
    }
}
fetchEvents();


const form = document.querySelector("#regForm");
form.onsubmit = (e) => {
    e.preventDefault(); 
    const { userName, userEmail } = form.elements;
    if(!userName.value || !userEmail.value) {
        document.querySelector("#formMsg").textContent = "Errors inline";
        return;
    }
    document.querySelector("#formMsg").textContent = "Submitting...";
    
    
    fetch("https://jsonplaceholder.typicode.com/posts", {
        method: "POST",
        body: JSON.stringify({ name: userName.value, email: userEmail.value })
    })
    .then(r => r.json())
    .then(data => {
        setTimeout(() => {
            document.querySelector("#formMsg").textContent = "Success!";
            registerUser(); 
        }, 1000);
    })
    .catch(err => {
        document.querySelector("#formMsg").textContent = "Failure!";
    });
};



$(document).ready(function(){
    $(document).on("click", ".reg-btn", function() {
        alert("jQuery Click Handled!");
        $(this).parent().fadeOut().fadeIn();
    });
});
