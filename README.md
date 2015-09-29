[![Build Status](https://travis-ci.org/bolshakov/activeadmin_sortable_table.svg?branch=master)](https://travis-ci.org/bolshakov/activeadmin_sortable_table)
[![Code Climate](https://codeclimate.com/github/bolshakov/activeadmin_sortable_table/badges/gpa.svg)](https://codeclimate.com/github/bolshakov/activeadmin_sortable_table)
[![Gem Version](https://badge.fury.io/rb/activeadmin_sortable_table.svg)](http://badge.fury.io/rb/activeadmin_sortable_table)

# Active Admin Sortable Table

This gem extends ActiveAdmin so that your index page's table rows can be
orderable via a drag-and-drop interface.

## Prerequisites

This extension assumes that you're using one of the following on any model you want to be sortable.

#### ActiveRecord

[acts_as_list](https://github.com/swanandp/acts_as_list)

```ruby
class Page < ActiveRecord::Base
  acts_as_list
end
```

## Usage

### Add it to your Gemfile

```ruby
gem "activeadmin_sortable_table"
```

### Include the JavaScript in active_admin.js.coffee

```coffeescript
#= require activeadmin_sortable_table
```

### Include the Stylesheet in active_admin.css.scss

```scss
@import "activeadmin_sortable_table"
```

### Configure your ActiveAdmin Resource

```ruby
ActiveAdmin.register Page do
  include ActiveAdmin::SortableTable # creates the controller action which handles the sorting
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate = false # optional; drag-and-drop across pages is not supported
  permit_params :position # do not forget to add `position` attribute to permitted prams

  index do
    handle_column # inserts a drag handle
    # use a user-defined URL for ordering
    handle_column url: :sort_admin_section_path
    # alternative form with lambda
    handle_column url: -> (resource) { compute_url_from_resource(resource) }
    # other columns...
  end

  show do |c|
    attributes_table do
      row :id
      row :name
    end

    panel 'Contents' do
      table_for c.collection_memberships do
        handle_column
        column :position
        column :collectable
      end
    end
  end
end
```

### Overriding handler

You can override handler column symbol using CSS:

```css
/* active_admin.css.scss */
@import "activeadmin_sortable_table";

.activeadmin_sortable_table .handle:before {
   content: '☰';
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
