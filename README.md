# mysqlbackup Cookbook

This cookbook installs [mysqlbackup](https://code.google.com/p/mysqlbackup/).

## Requirements

- `mysql` - Obviously, MySQL is required

## Attributes

#### mysqlbackup::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mysqlbackup']['enable_duply']</tt></td>
    <td>Boolean</td>
    <td>whether to enable duply</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['mysqlbackup']['enable_mysql']</tt></td>
    <td>Boolean</td>
    <td>whether to enable MySQL</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['mysqlbackup']['group']</tt></td>
    <td>String</td>
    <td>the group name for the system user running mysqlbackup</td>
    <td><tt>backup</tt></td>
  </tr>
  <tr>
    <td><tt>['mysqlbackup']['mysql_password']</tt></td>
    <td>String</td>
    <td>the password for the MySQL user</td>
    <td><tt>CHANGE_THIS_PASSWORD</tt></td>
  </tr>
  <tr>
    <td><tt>['mysqlbackup']['mysql_user']</tt></td>
    <td>String</td>
    <td>the username for the MySQL user</td>
    <td><tt>backup</tt></td>
  </tr>
  <tr>
    <td><tt>['mysqlbackup']['user']</tt></td>
    <td>String</td>
    <td>the username for the system user running mysqlbackup</td>
    <td><tt>backup</tt></td>
  </tr>
  <tr>
    <td><tt>['mysqlbackup']['version']</tt></td>
    <td>String</td>
    <td>the version number for mysqlbackup to install</td>
    <td><tt>2.7</tt></td>
  </tr>
</table>

## Usage

Include `mysqlbackup` in your node's `run_list`:

```json
{
  "name": "node",
  "run_list": [
    "recipe[mysqlbackup]"
  ]
}
```

Make sure you also supply the password for the MySQL `root` user with the `node['mysql']['server_root_password']` attribute when you enabled creating a dedicated read-only user account for backup.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: [Lennard Timm](https://github.com/lenn4rd)
