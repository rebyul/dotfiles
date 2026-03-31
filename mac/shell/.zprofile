eval "$(/opt/homebrew/bin/brew shellenv)"

##
# Your previous ${HOME}/.zprofile file was backed up as ${HOME}/.zprofile.macports-saved_2022-11-14_at_19:10:57
##

# MacPorts Installer addition on 2022-11-14_at_19:10:57: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2022-11-14_at_19:10:57: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.

# Add .NET Core SDK tools
export PATH="$PATH:${HOME}/.dotnet/tools"
