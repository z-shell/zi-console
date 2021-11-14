#
# No plugin manager is needed to use this file. All that is needed is adding:
#   source {where-zinit-view-is}/zinit-view.plugin.zsh
#
# to ~/.zshrc. But of course, this plugin is an extension to ZI.
#

# Standarized $0 handling
# http://z-shell.github.io/zinit/wiki/zsh-plugin-standard/
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"
t
typeset -gA Plugins
Plugins[ZICONSOLE_REPO_DIR]="${0:h}"

if [[ "${+functions[-zui_std_cleanup]}" = "0" ]]; then
    echo "The zinit consolette uses ZUI plugin, please load https://github.com/z-shell/zui/ with your plugin manager, or source it."
fi

#
# Update FPATH if:
# 1. Not loading with Zplugin or other plugin manager supporting the plugin standard
# 2. Not having fpath already updated (that would equal: using other plugin manager)
#

if [[ $zsh_loaded_plugins[-1] != */zinit-console && -z $fpath[(r)${0:h}] ]]
then
    fpath+=( "${0:h}" )
fi

[[ -z "${fg_bold[green]}" ]] && builtin autoload -Uz colors && colors

autoload -- ziconsole zpconsole

zle -N ziconsole
bindkey "^O^J" ziconsole
