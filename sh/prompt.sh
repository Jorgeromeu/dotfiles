autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%B%F{yellow}[%b]%f'
zstyle ':vcs_info:*' enable git

git="\$vcs_info_msg_0_%b"
err='%(?..%B%F{red}[%?]%f%b)'
wd='%B%F{blue}[%5~]%f%b'

gits="\$vcs_info_msg_0_%b"
errs='%(?..%B%F{red}%?%f%b)'
wds='%B%F{blue}%5~%f%b'

# PROMPT="${err}${git}${wd} "
PROMPT="${err}${git}${wd} "
