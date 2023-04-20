local return_status="%{$fg[red]%}%(?..⏎)%{$reset_color%}"

# PROMPT='
# %D{%a - %b %d, %Y} %{$fg_bold[blue]%}[%{$fg[yellow]%}%D{%l:%M %p}%{$fg[blue]%}]%{$reset_color%} | %{$fg[cyan]%}%10c%{$reset_color%} $(git_prompt_info)$(git_prompt_short_sha) 
# %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )'

PROMPT='
%{$fg_bold[blue]%}[%{$fg[yellow]%}%D{%l:%M %p}%{$fg[blue]%}]%{$reset_color%} %{$fg[cyan]%}%10c%{$reset_color%} $(git_prompt_info)%{$fg_bold[blue]%}[%{$fg[yellow]%}%D{$(git_prompt_short_sha)}%{$fg[blue]%}]% 
%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )'

# RPROMPT='${return_status}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[green]%}✔"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg_bold[magenta]%}↓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg_bold[magenta]%}↑%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg_bold[magenta]%}↕%{$reset_color%}"

