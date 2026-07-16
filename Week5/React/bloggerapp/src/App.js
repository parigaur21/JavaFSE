import React, { useState } from 'react';
function App() {
    const [view, setView] = useState('book');
    return (
        <div>
            <button onClick={() => setView('book')}>Book</button>
            <button onClick={() => setView('blog')}>Blog</button>
            <button onClick={() => setView('course')}>Course</button>
            {view === 'book' && <BookDetails />}
            {view === 'blog' && <BlogDetails />}
            {view === 'course' && <CourseDetails />}
        </div>
    );
}
function BookDetails() { return <h2>Book Details Component</h2>; }
function BlogDetails() { return <h2>Blog Details Component</h2>; }
function CourseDetails() { return <h2>Course Details Component</h2>; }
export default App;
