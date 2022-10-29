# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Init zplug
source ~/.zplug/init.zsh

# zsh History config
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# zplug plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'romkatv/powerlevel10k', as:theme, depth:1
zplug "zsh-users/zsh-completions"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zpm-zsh/ls"
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/composer", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "b4b4r07/enhancd", use:init.sh
zplug "plugins/kubectl", from:oh-my-zsh

# plugins config
# zpm-zsh/ls
export ZSH_LS_DISABLE_GIT=true
# plugins/docker
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Install packages that have not been installed yet
if ! zplug check; then
    zplug install
fi

# source plugins and add commands to the PATH
zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
