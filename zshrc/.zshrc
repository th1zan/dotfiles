# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code requiring user input must go above this block.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# === PATH Configuration ===
# Add custom scripts and tools to the PATH
export PATH="$HOME/scripts:$HOME/.local/share/nvim/mason/bin:$HOME/go/bin:$PATH"
export GOPATH=$HOME/go
export LANG=en_US.UTF-8

# === Aliases ===
alias c="clear"
alias e="exit"
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'
alias f="fzf"
alias ls="eza --no-filesize --long --color=always --icons=always --no-user"
alias tree="tree -L 3 -a -I '.git' --charset X"
alias dtree="tree -L 3 -a -d -I '.git' --charset X"
alias gt="git"
alias ga="git add ."
alias gs="git status -s"
alias gc='git commit -m'
alias glog='git log --oneline --graph --all'
alias lg="lazygit"

# zoxide (smart directory navigation)
eval "$(zoxide init --cmd cd zsh)"

# fzf (fuzzy finder)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

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


# # ripgrep->fzf->neovim [QUERY]
# rfv() (
#   RELOAD='reload:rg --column --color=always --smart-case {q} || :'
#   OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
#             nvim {1} +{2}     # No selection. Open the current line in Neovim.
#           else
#             nvim +cw -q {+f}  # Build quickfix list for the selected items.
#           fi'
#   fzf --disabled --ansi --multi \
#       --bind "start:$RELOAD" --bind "change:$RELOAD" \
#       --bind "enter:become:$OPENER" \
#       --bind "ctrl-o:execute:$OPENER" \
#       --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
#       --delimiter : \
#       --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
#       --preview-window '~4,+{2}+4/3,<80(up)' \
#       --query "$*"
# )

source ~/scripts/fzf-git.sh

autoload -U compinit; compinit
source $HOME/scripts/fzf-tab/fzf-tab.plugin.zsh

# Alias pour utiliser fzf pour sélectionner une branche
alias fgb='_fzf_git_branches'
# Alias pour utiliser fzf pour sélectionner un commit
alias fgc='_fzf_git_hashes'
# Alias pour afficher les fichiers modifiés dans fzf
alias fgf='_fzf_git_files'
# Alias pour afficher les tags Git dans fzf
alias fgt='_fzf_git_tags'

# thefuck (fix shell command typos)
eval $(thefuck --alias)

# Powerlevel10k prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Autocomplete and Syntax Highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

##zsh-syntax-highlighting options
#source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Editor Configuration
export EDITOR="nvim"

# Configuration for pyenv as https://laict.medium.com/install-python-on-macos-11-m1-apple-silicon-using-pyenv-12e0729427a9
export PYENV_ROOT="$HOME/.pyenv" 
export PATH="$PYENV_ROOT/bin:$PATH" 
eval "$(pyenv init --path)" 
eval "$(pyenv init -)"


# Fast system info fetch
fastfetch
