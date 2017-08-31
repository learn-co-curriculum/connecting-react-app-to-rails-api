# Connecting React App to Rails API

## Objectives

* Connecting a Create React App to IronStarter Rails API
* Review Rack CORS and add Create React App Domain to Allowed Origins
* Create List View Component of campaigns from IronStarter API

## Introduction

In this lesson we are going to take our two new tools (Create React App & Rails 5 API Template) and connect them. This will be a bit of review with some new things mixed in. The main goal here is to see how they can connect. 

## App Layout

Lets take a look at our current directory. We should have an api folder that has our Rails API in it. Let's go ahead and cd into this directory and setup the database and server. 

```
cd api 
bundle install 
rails db:migrate
```

We are going to do something different this time. Remember how Create React App runs on port 3000? We should run our Rails app on port 3001, so that we can run Create React App on 3000. To do this we just use the `-p 3001` flag after `rails server`. Let's try it out

```
rails server -p 3001
```

Everything should work the same, you can try out a __curl__ command or use the [Postman Chrome Extension](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop) or [Rested App](https://itunes.apple.com/us/app/rested-simple-http-requests/id421879749?mt=12)


### Summary

// Go Over What We Learned In This Readme

<p class='util--hide'>View <a href='https://learn.co/lessons/connecting-react-app-to-rails-api'>Connecting React App to Rails API</a> on Learn.co and start learning to code for free.</p>