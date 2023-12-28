# based on: https://www.hanselman.com/blog/my-ultimate-powershell-prompt-with-oh-my-posh-and-the-windows-terminal

# TODO: install fonts
# TODO: update terminal

winget install JanDeDobbeleer.OhMyPosh
refreshenv

oh-my-posh --init --shell pwsh --config D:/Dropbox/ohmyposhv3-2.json | Invoke-Expressio

. $PROFILE

Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module PSReadLine -AllowPrerelease -Force

# TODO: update $profile