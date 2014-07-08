# Chef Graphite Cookbook

## Requirements

### Platform: Ubuntu 14.04

## Attributes

- `node['oc-graphite']['carbon_cache']['enable']`: Enable or disable the carbon-cache service (default `true`)
- `node['oc-graphite']['carbon']['data_dir']`: The data directory for whisper files (default `/var/lib/graphite/whisper/`)
- `node['oc-graphite']['carbon']['user']`: The user for the carbon service (default `_graphite`)
- `node['oc-graphite']['web']['secret_key']`: The secret key for the Django app: (default `0aed5c39507562f4519c2d47515e8221`)
- `node['oc-graphite']['web']['time_zone']`: The time zone used for the Django app (default `America/Los_Angeles`)
- `node['oc-graphite']['web']['server']`: Which web server to use, `nginx` and `uwsgi` are currently supported (default `uwsgi`)
- `node['oc-graphite']['web']['seed_password']`: A seed password for graphite_web's admin user, this will not change after initialization (default `changeme`)
- `node['oc-graphite']['_uwsgi']['listen_ip']`: The IP to listen on (default `0.0.0.0`)
- `node['oc-graphite']['_uwsgi']['listen_port']`: The port to listen on (default `8080`)
- `node['oc-graphite']['_nginx']['disable_node_vhost']`: Set to `true` to disable the default vhost dropped in place for nginx (default `false`)
- `node['oc-graphite']['_nginx']['hostname']`: The hostname used by the nginx vhost, if left as nil the FQDN is used (default `nil`)

## Recipes

### default

The default recipe doesn't do anything because graphite doesn't really have a client.

### graphite_carbon

Sets up the carbon service (carbon-cache, carbon-relay and carbon-aggregator).  This recipe also manages the configs for storage schemas/aggregations.

### graphite_web

Sets up the graphite web interface as well as nginx/uwsgi.  This will include the `_uwsgi` recipe and will include the `_nginx` recipe if `node['oc-graphite']['web']['server']` is set to `nginx`.

### _uwsgi

Installs the `uwsgi` service and sets up/enables the graphite vhost.

### _nginx

Installs the `nginx` service and sets up/enables the graphite vhost.

## Usage

An example role:

```
{
  "name": "graphite",
  "description": "Graphite Server",
  "default_attributes": {
    "oc-graphite": {
      "web": {
        "secret_key": "This key is super secret!",
        "server": "nginx"
      },
      "_nginx": {
        "disable_default_vhost": true,
        "hostname": "graphite.example.com"
      }
    }
  },
  "run_list": [
    "recipe[oc-graphite::graphite_carbon]",
    "recipe[oc-graphite::graphite_web]"
  ]
}
```


## Testing

The cookbook provides the following Rake tasks for testing:

    rake foodcritic                   # Lint Chef cookbooks
    rake integration                  # Alias for kitchen:all
    rake kitchen:all                  # Run all test instances
    rake kitchen:node-ubuntu-1204     # Run default-ubuntu-1204 test instance
    rake rubocop                      # Run RuboCop style and lint checks
    rake spec                         # Run ChefSpec examples
    rake test                         # Run all tests

## License and Author

- Author: Chef Operations
- Copyright (C) 2014, Chef Software, Inc

All rights reserved.


