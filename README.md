# cog_nginx-cookbook

Installs NGINX nginx-release rpm and nginx
provides cog_nginx_site

## Supported Platforms

Centos 7

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['cog_nginx']['manage_logentries']</tt></td>
    <td>Boolean</td>
    <td>whether to create configuration files for logentries agent</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['cog_nginx']['install_monitoring_site']</tt></td>
    <td>Boolean</td>
    <td>whether to create site for monitoring tools</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### cog_nginx::default

NB! EPEL Nginx package by fedault will OVERWRITE nginx from nginx

To avoid this, reduce priority of EPEL repository

default['yum']['epel']['priority'] = '2'

Include `cog_nginx` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[cog_nginx::default]"
  ]
}
```

## License and Authors

Author:: Lauri Jesmin (<lauri.jesmin@cashongo.co.uk>)
