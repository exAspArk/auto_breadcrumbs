# AutoBreadcrumbs

Automatically add breadcrumbs to each page by using locales and gem `breadcrumbs_on_rails`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auto_breadcrumbs'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auto_breadcrumbs

### Installing locales

To install locale file run:

    $ rails g auto_breadcrumbs:install

## Usage

1) Include `auto_breadcrumbs` in your controller:

```ruby
class UsersController < ApplicationController
  include AutoBreadcrumbs

  ...
end
```

2) Fill your locale file:

```yml
en:
  breadcrumbs:
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

## Customization

For more information about breadcrumbs' customization visit [breadcrumbs_on_rails](https://github.com/weppos/breadcrumbs_on_rails).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO

* Add tests
* Add supporting of nested resources
