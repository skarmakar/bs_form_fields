# BsFormFields

This gem provides extended form field methods to generate form labels and input fields following Bootstrap styling. Write less, and
modify/switch easily.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bs_form_fields'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bs_form_fields

## Usage

This gem simplifies writing the forms following bootstrap styling. Currently supporting bootstrap 5 only.

Configure the renderer in a initializer file like below:

```ruby
# config/initializers/bs_form_fields.rb
BsFormFields.renderer = :bootstrap_five
```
and use a `bs_` before all the field names like the example below:

```ruby
<%= form_for :session, url: session_path do |f| %>
  <%= f.bs_text_field :email, required: true, label: 'Username' %> # default label is field_name humanized a titleized
  <%= f.bs_password_field :password, required: true %>
  <%= f.bs_submit_button "Login" %> # default is submit
<% end %>

```

and this will generate html like below:

```html
<form action="/session" accept-charset="UTF-8" method="post">
  <input name="utf8" type="hidden" value="✓">
  <input type="hidden" name="authenticity_token" value="xxx">
  
  <div class="mb-3">
    <label class="form-label" for="session_text_field">Username *</label>
    <input required="required" label="Username *" class="form-control" type="text" name="session[email]" id="session_email">
  </div>

  <div class="mb-3">
    <label class="form-label" for="session_password_field">Password *</label>
    <input required="required" class="form-control" type="password" name="session[password]" id="session_password">
  </div>
  
  <button name="button" type="submit" class="btn btn-primary btn-lg">Login</button>
</form>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/skarmakar/bs_form_fields.

