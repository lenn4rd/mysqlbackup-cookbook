default['mysqlbackup']['version'] = '2.7'

# The user and group to run mysqlbackup as
default['mysqlbackup']['user']  = 'backup'
default['mysqlbackup']['group'] = 'backup'

# Create a dedicated MySQL user with read-only access
default['mysqlbackup']['enable_mysql'] = false

# Enter the username and password if you enabled creating a MySQL user
default['mysqlbackup']['mysql_username'] = 'backup'
default['mysqlbackup']['mysql_password'] = 'CHANGE_THIS_PASSWORD'

# Don't create duply pre backup script
default['mysqlbackup']['enable_duply'] = false
