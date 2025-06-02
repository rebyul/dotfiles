# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Python path + gmake -> make
export PATH=$PATH:/Users/donghankim/workspace/flutter/bin:/opt/homebrew/opt/make/libexec/gnubin:/usr/local/go/bin:~/go/bin

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.G
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# # Export nvm completion settings for zsh-nvm plugin
# export NVM_LAZY_LOAD=true
# export NVM_COMPLETION=true
# export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nx', 'pnpm', 'vim', 'nvim')

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
  # nvm
  # macos
)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Key bindings
bindkey "\e\e[D" backward-word # alt-left -> skip word
bindkey "\e\e[C" forward-word

if [[ ${TERM_PROGRAM} = "iTerm.app" ]]; then
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# starship init
eval "$(starship init zsh)"

#zoxide init
eval "$(zoxide init zsh)"

# if any of these files are modified, re-save zgenom
ZGENOM_RESET_ON_CHANGE=(
  "${HOME}/.zshrc"
)

# Disable as it makes it difficult to ssh to server which starts its own tmux
# ZSH_TMUX_AUTOSTART=true 

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# if the init scipt doesn't exist
if ! zgenom saved; then
    echo "Creating a zgenom save"
    zgenom compdef

    # zgenom load lukechilds/zsh-nvm
    zgenom ohmyzsh

    # plugins
    zgenom ohmyzsh plugins/git
    # zgenom ohmyzsh plugins/nvm
    zgenom ohmyzsh plugins/sudo
    zgenom ohmyzsh plugins/macos
    zgenom ohmyzsh plugins/tmux
    zgenom ohmyzsh plugins/docker
    zgenom ohmyzsh plugins/docker-compose
    zgenom ohmyzsh plugins/dotnet
    zgenom ohmyzsh plugins/command-not-found
    zgenom ohmyzsh plugins/colored-man-pages
    zgenom ohmyzsh plugins/deno
    zgenom ohmyzsh --completions custom/plugins/pnpm

    # zgenom load agkozak/zsh-z
    # completions
    zgenom load zsh-users/zsh-completions
    zgenom load jscutlery/nx-completion
    zgenom ohmyzsh --completions plugins/bat

    # bulk load
    zgenom loadall <<EOPLUGINS
        zsh-users/zsh-history-substring-search
        zsh-users/zsh-autosuggestions
        zdharma-continuum/fast-syntax-highlighting
EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # theme
    # zgenom ohmyzsh themes/agnoster

    # save all to init script
    zgenom save
    # Compile your zsh files
    zgenom compile "$HOME/.zshrc"
fi

# pnpm
export PNPM_HOME="/Users/donghankim/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Set up fzf key bindings and fuzzy completion
export FZF_DEFAULT_OPTS='--tmux'
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
  # CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
  # Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

source <(fzf --zsh)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if [ -e ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Allow glob matches? https://github.com/ohmyzsh/ohmyzsh/issues/31
# 23-07-24 doesn't seem necessary anymore? Can do git add *.js etc
# unsetopt nomatch

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/donghankim/workspace/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/donghankim/workspace/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/donghankim/workspace/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/donghankim/workspace/google-cloud-sdk/completion.zsh.inc'; fi

# fnm
export PATH="/Users/donghankim/Library/Application Support/fnm:$PATH"
eval "`fnm env --use-on-cd --version-file-strategy=recursive --shell zsh`"

# source ~/completion-for-pnpm.zsh

