# based on: https://www.hanselman.com/blog/my-ultimate-powershell-prompt-with-oh-my-posh-and-the-windows-terminal

# TODO: install fonts
# TODO: update terminal

winget install JanDeDobbeleer.OhMyPosh
refreshenv

oh-my-posh --init --shell pwsh --config https://raw.githubusercontent.com/MarioStreubel/terminal-setup/main/powershell/oh-my-posh/ohmyposhv3-v2.json | Invoke-Expression

. $PROFILE

Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module PSReadLine -AllowPrerelease -Force

# TODO: update $profile