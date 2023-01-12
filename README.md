# clockify-autoEntry
Small script to retroactively create time entries in Clockify

## Before Use
 - Get your clockify api key from your [user settings](https://app.clockify.me/user/settings)
 - Install [clockify-cli](https://github.com/lucassabreu/clockify-cli)
 - Run `clockify-cli config init` asdf
 
## About
clockify.sh fetches the date of your last time entry and automatically creates entries for any weekday between then and now
