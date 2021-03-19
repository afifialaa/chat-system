# Instabug Back End Challenge

This repository is a REST api for a chat system. Built with Ruby/Rails and MySQL as main database.
* Ruby 3.0.0
* Rails 6.1.3
* MySQL
* Elasticsearch 7.11
* Redis 6.2

## Installation

1. Clone the repository

```bash
git clone https://github.com/afifialaa/chat-system/tree/master/app
```
2.  Install the dependencies specified in the Gemfile
```bash
bundle install
```
4. Create and setup the database
```bash
rails db:create
rails db:migrate
```
3. Start local server
```bash
rails s
```
And now you can visit the site with the URL http://localhost:3000

## Usage

### User routes

| Method        | URL          |
| ------------- | -------------|
| POST          | /user/create |
| GET           | /user/login  |

### Application routes

| Method        | URL                  | description            |
| ------------- | -------------        |-------------           |
| POST          | /applications/create  |create new application  |
| GET           | /applications/:token  |get chats in application|
| DELETE        | /applications/:token/delete  |delete application|
| PUT           | /applications/:token/:name  |update application name|

### Chat routes

| Method        | URL                  | description            |
| ------------- | -------------        |-------------           |
| POST          | /applications/:token/chats/create  |create new chat  |
| GET           | /applications/:token/chats/:num  |get chat from application|
| DELETE        | /applications/:token/chats/delete/:num |delete chat|

### Message routes

| Method        | URL                  | description            |
| ------------- | -------------        |-------------           |
| POST          | /applications/:token/chats/:num/message  |create new message  |
| DELETE           | /applications/:token/chats/:num/message/delete/:message_id  |get chat from application|
| GET        | /applications/:token/chats/:num/message/search/:query |delete chat|

## Pending
* Incrementing chat number in an application
* Optimizing database queries