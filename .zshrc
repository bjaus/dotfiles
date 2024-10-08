# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# ZSH_THEME="af-magic"
# ZSH_THEME="agnoster" # blue & yell
# ZSH_THEME="arrow" # simple gold
# ZSH_THEME="aussiegeek"
# ZSH_THEME="avit"
# ZSH_THEME="bira"
# ZSH_THEME="bureau"
# ZSH_THEME="cloud"
# ZSH_THEME="crunch"
# ZSH_THEME="darkblood"
# ZSH_THEME="daveverwer"
# ZSH_THEME="dieter"
# ZSH_THEME="duellj"
# ZSH_THEME="eastwood"
# ZSH_THEME="emotty" # requires "emotty" and "emoji" plugin
# ZSH_THEME="essembeh"
# ZSH_THEME="fino" # I really like this one
# ZSH_THEME="fox"
# ZSH_THEME="gallois"
# ZSH_THEME="half-life"
# ZSH_THEME="intheloop"
# ZSH_THEME="jispwoso"
# ZSH_THEME="jnrowe"
# ZSH_THEME="jonathan"
# ZSH_THEME="mh"
# ZSH_THEME="miloshadzic" # minimal and sleak
# ZSH_THEME="mlh"
# ZSH_THEME="mrtazz"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="sorin"
# ZSH_THEME="strug"
# ZSH_THEME="superjarin"
# ZSH_THEME="terminalparty"
# ZSH_THEME="theunraveler"
# ZSH_THEME="tjkirch"
ZSH_THEME="zhann"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

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
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git aliases autojump emoji emotty)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="$HOME/.scripts:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Setup autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Setup pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Setup goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.goenv/shims:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

if [ -f $HOME/.config/atuin/config.toml ]; then
  if [ -f $HOME/.atuin/bin/env ]; then
    source "$HOME/.atuin/bin/env"
  fi
  eval "$(atuin init zsh)"
fi

if [ -f $HOME/.tnsrc ]; then 
    source $HOME/.tnsrc 
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.

alias cat="bat"
alias clip="tr -d '\n' | pbcopy"
alias pn="pnpm"
# alias vim="nvim"

[ -f "$HOME/.zshrc.extended" ] && . "$HOME/.zshrc.extended"
