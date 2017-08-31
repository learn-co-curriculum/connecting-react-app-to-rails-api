# Connecting React App to Rails API

## Objectives

* Connecting a Create React App to the Iron Starter Rails API
* Review Rack CORS and add Create React App Domain to Allowed Origins
* Create list view of Campaigns in the App component

## Introduction

In this lesson we are going to take our two new tools (Create React App & Rails 5 API Template) and connect them. This will be a bit of review with some new things mixed in. The main goal here is to see how they can connect. 

## App Layout

When we take a look at our main directory there is an api folder that contains the Rails API in it. Let's go ahead and cd into this directory, setup the database and run the server. 

```
cd api 
bundle install 
rails db:migrate
rails db:seed
```

We are going to run the server differently this time. Remember how Create React App runs on port 3000? We should run our Rails app on port 3001, so that we can keep the Create React App on port 3000. To do this we just use the `-p 3001` flag after `rails server`. Let's try it out:

```
rails server -p 3001
```

Everything should work the same, fell free to try it out with a __curl__ command, [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop) or [Rested](https://itunes.apple.com/us/app/rested-simple-http-requests/id421879749?mt=12).

### Creating React App

Now that our Rails app is running lets open up a new terminal window and `cd ..` back to our main directory (where this README.md file lives) and run:

```
create-react-app client
cd client
npm start
```

This should open up the React app in the browser again at localhost:3000

### Fetching Campaigns

This app will look almost identical to our small JS/HTML app we built a couple of lessons ago. To build it, we first need to clear out the `/client/src/app.js` file and change it to:

```javascript 
import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {

  componentDidMount() {

  }
  
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1>Iron Starter</h1>
        </div>
        <p className="App-intro">
          Current Campaigns
        </p>
      </div>
    );
  }
}

export default App;
``` 

Next let's make a fetch request to test if we can connect to our Rails API. The `fetch` call should live inside of the `componentDidMount()` lifecycle function and log the response. 

```javascript
// /client/src/app.js

componentDidMount() {
    fetch('http://localhost:3001/api/campaigns')
        .then(response => response.json())
        .then(campaigns => console.log(campaigns));
}
```

When we check out the dev console in the browser though we won't see a log with our campaigns. Instead we will see 'Fetch API cannot load http://localhost:3001/api/campaigns. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:3000' is therefore not allowed access. If an opaque response serves your needs, set the request's mode to 'no-cors' to fetch the resource with CORS disabled.' Rememeber CORS? We need to get used to learning, knowing, recognizing and dreaming about CORS. So how do we resolve this again? Yep, that right __Rack CORS__! Let's go to our api directory and set up CORS again. 

### CORS Review

The first step is to make sure that the Rack CORS gem is in the Gemfile and run `bundle install`

```ruby 
# /api/Gemfile 

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
```

The second step should be to add `localhost:3000` to our list of allowed Origins in the `/api/config/initializers/cors.rb` file, since our Client app is running on localhost port 3000

```ruby 
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3000' # <- Create React App port URL

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

We need to reset our Rails server for these changes to take affect.

```
rails server -p 3001
```

If we check out the React app in the browser again, there should be an array of Campaigns logged from our Iron Starter API request. Next let's add some code and render these items to the App component.

```javascript 
// client/src/App.js

import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {

  constructor(props) {
    super(props)

    this.state = {
      campaigns: []
    }
  }

  componentDidMount() {
    fetch('http://localhost:3001/api/campaigns')
        .then(response => response.json())
        .then(campaigns => this.setState({ campaigns }));
  } 

  render() {
    const campaignCardStyle = {
      border: '1px solid #00d8ff',
      margin: '16px',
      padding: '16px',
    }

    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1>Iron Starter</h1>
        </div>
        <div className="App-intro">
          <h2>Current Campaigns</h2>
          {this.state.campaigns.map(campaign => (
            <div key={campaign.id} style={campaignCardStyle}>
              <h3>{campaign.title}</h3>
              <h4>Goal: {campaign.goal}</h4>
              <h4>Pledged: {campaign.pledged}</h4>
              <p>{campaign.description}</p>
            </div>
          ))}
        </div>
      </div>
    );
  }
}

export default App;
```

First stage of Iron Starter is complete. Client app is talking to the API app, and things are looking good. In the next couple of lessons we are going to finish up our Rails API and start making POST, PUT and DELETE request from our Client App. 

### Summary

Let review what we did here. FIrst we organized Rails API and Client App to live in seperate directories. Then we connected them using a `fetch` request. Next we setup CORS to allow request from `localhost:3000`. Then we displayed the list of Campaigns in the App component. Not bad for a short amount of time. 

This is the file setup we will be using for the rest of the section, so make sure to get comfortable going in and out of the directories to manage the running servers.

<p class='util--hide'>View <a href='https://learn.co/lessons/connecting-react-app-to-rails-api'>Connecting React App to Rails API</a> on Learn.co and start learning to code for free.</p>