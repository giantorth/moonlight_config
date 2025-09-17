# Moonlight Helper Scripts

Configure Moonlight do/undo commands with these scripts to auto set resolution
Current scripts only work on a Linux KDE system

Set do command as follows, dont forget to make script executable after downloading and configure path to your own location:
``` bash -c "/path/to/scripts/moonlight-on.sh \"${SUNSHINE_CLIENT_WIDTH}\" \"${SUNSHINE_CLIENT_HEIGHT}\" \"${SUNSHINE_CLIENT_FPS}\"" ```

Undo command:
``` /path/to/scripts/moonlight-off.sh ```

The games folder contains a couple helper scripts to launch games and automatically set the game's config to the values of your current default monitor.

Configure steam launch parameters like this example:
``` /path/to/scripts/cyberpunk.sh %command% ```