import React, { Component } from 'react';
class Posts extends Component {
    constructor(props) {
        super(props);
        this.state = { posts: [], error: null };
    }
    componentDidMount() { this.loadPosts(); }
    componentDidCatch(error, info) {
        this.setState({ error });
        alert("An error occurred: " + error);
    }
    loadPosts() {
        fetch('https://jsonplaceholder.typicode.com/posts')
            .then(response => response.json())
            .then(data => this.setState({ posts: data.slice(0, 5) }))
            .catch(error => this.setState({ error }));
    }
    render() {
        if (this.state.error) return <div>Error loading posts</div>;
        return (
            <div>
                <h2>Posts</h2>
                {this.state.posts.map(post => (
                    <div key={post.id}>
                        <h3>{post.title}</h3>
                        <p>{post.body}</p>
                    </div>
                ))}
            </div>
        );
    }
}
export default Posts;
