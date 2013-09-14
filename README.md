# ClientVariable

exports your rails variables to client-side

## Installation

Add this line to your application's Gemfile:

    gem 'client_variable'

After you install and add it to your Gemfile, you need to run the generator:

    rails g client_variable:install

It will create client_variable.yml in config folder, these variable in this file will be merged with variables defined through controller, exported to client-side

## Usage

Add this line to `app/views/layouts/application.html.erb`

``` erb
<head>
  <title>some title</title>
  <%= include_variable %>
  <!-- include your action js code -->
  ...
```

Inspired from gon - https://github.com/gazay/gon, you can also do these in your controller

  1. Write variables by(change each request)

    ```ruby
    client.variable_name = variable_value

    client.push({
      :user_id => 1,
      :user_role => "admin"
    })
    ```

  2. Or global
    You can use client.global for sending your data to js from anywhere! It's really great for some init data.
    ``` ruby
    client.global.variable_name = variable_value
    ```

Add this line on top of `app/assets/javascripts/application.js`
``` js
//= require variable
```
I also define global variable in javascript `rails`
Access the varaibles from your JavaScript file:

``` js
rails.set('a.b.c.d', '123') # rails.values => {a: {b: {c: {d: '123'}}}}
rails.get('a.b.c.d') # => '123'
```
