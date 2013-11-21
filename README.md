# Auto Breadcrumbs [![Build Status](https://travis-ci.org/exAspArk/auto_breadcrumbs.png)](https://travis-ci.org/exAspArk/auto_breadcrumbs)

Automatically add breadcrumbs to each page by using locales and gem `breadcrumbs_on_rails`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auto_breadcrumbs'
```

And then execute:

    $ bundle

To generate locale file run:

    $ rails g auto_breadcrumbs:install

## Usage

1) Include `auto_breadcrumbs` in your controller:

```ruby
class ApplicationController < ActionController::Base
  include AutoBreadcrumbs
  ...
end
```

2) Fill your locale file:

```yml
en:
  auto_breadcrumbs:
    root: 'Home'
    actions:
      new: 'New'
      show: 'Show'
      edit: 'Edit'
    controllers:
      users:
        index: 'Users'
        edit: 'Settings'
        sync: 'Synchronization'
      ...
```

3) Use helper method to show breadcrumbs in your view file:

```erb
<body>
  <%= render_breadcrumbs %>
</body>
```

For example, if you go to `/users/1/edit` it will show breadcrums like `Home / Users / Settings`.

In case when translations are absent it will try to build breadcrumbs automatically depending on resource and action names.
For example, if you visit `/countries/new` it will show breadcrums `Home / Countries / New`.

## Customization

For more information about customization of breadcrumbs visit [breadcrumbs_on_rails](https://github.com/weppos/breadcrumbs_on_rails).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
