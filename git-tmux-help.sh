#!/bin/bash

# Git and Tmux Alias/Function Discovery Tool
# Run this script to explore available git and tmux commands

show_git_aliases() {
    echo "==============================================="
    echo "              GIT ALIASES"
    echo "==============================================="
    echo
    echo "STATUS COMMANDS:"
    echo "  gs    - git status"
    echo "  gsb   - git status -s -b (short with branch)"
    echo "  gss   - git status -s (short)"
    echo
    echo "ADD/STAGE COMMANDS:"
    echo "  ga    - git add"
    echo "  gaa   - git add --all"
    echo "  gap   - git add --patch (interactive)"
    echo
    echo "COMMIT COMMANDS:"
    echo "  gc    - git commit"
    echo "  gca   - git commit --amend"
    echo "  gcam  - git commit -am (add and commit)"
    echo "  gcan  - git commit --amend --no-edit"
    echo "  gcm   - git commit -m"
    echo
    echo "PUSH COMMANDS:"
    echo "  gp    - git push"
    echo "  gpf   - git push --force-with-lease"
    echo "  gpo   - git push origin"
    echo "  gpoc  - git push origin current-branch"
    echo
    echo "PULL/FETCH COMMANDS:"
    echo "  gpl   - git pull"
    echo "  gplo  - git pull origin"
    echo "  gplom - git pull origin master"
    echo "  gf    - git fetch"
    echo "  gfa   - git fetch --all"
    echo "  gfo   - git fetch origin"
    echo
    echo "DIFF COMMANDS:"
    echo "  gd    - git diff"
    echo "  gdc   - git diff --cached"
    echo "  gds   - git diff --stat"
    echo
    echo "LOG COMMANDS:"
    echo "  gl    - git log --oneline"
    echo "  glg   - git log with pretty format"
    echo "  glp   - git log --patch"
    echo
    echo "BRANCH COMMANDS:"
    echo "  gb    - git branch"
    echo "  gba   - git branch -a (all)"
    echo "  gbd   - git branch -d (delete)"
    echo "  gbD   - git branch -D (force delete)"
    echo
    echo "CHECKOUT COMMANDS:"
    echo "  gco   - git checkout"
    echo "  gcob  - git checkout -b (new branch)"
    echo "  gcom  - checkout main/master"
    echo
    echo "REBASE COMMANDS:"
    echo "  gr    - git rebase"
    echo "  gra   - git rebase --abort"
    echo "  grc   - git rebase --continue"
    echo "  gri   - git rebase --interactive"
    echo
    echo "RESET COMMANDS:"
    echo "  gre   - git reset"
    echo "  greh  - git reset --hard"
    echo "  grehh - git reset --hard HEAD"
    echo
    echo "STASH COMMANDS:"
    echo "  gst   - git stash push"
    echo "  gstp  - git stash pop"
    echo "  gsta  - git stash apply"
    echo "  gstl  - git stash list"
    echo "  gsts  - git stash show -p"
    echo
    echo "OTHER COMMANDS:"
    echo "  gcp   - git cherry-pick"
    echo "  gcpa  - git cherry-pick --abort"
    echo "  gcpc  - git cherry-pick --continue"
    echo "  gm    - git merge"
    echo "  gma   - git merge --abort"
}

show_git_functions() {
    echo
    echo "==============================================="
    echo "         GIT INTERACTIVE FUNCTIONS"
    echo "==============================================="
    echo
    echo "BRANCH MANAGEMENT:"
    echo "  gco-fzf      - Interactive branch checkout with preview"
    echo "  gb-delete    - Delete multiple branches interactively"
    echo "  git-checkout - Checkout local/remote branches with fzf"
    echo
    echo "COMMIT MANAGEMENT:"
    echo "  gcp-fzf      - Interactive cherry-pick with preview"
    echo "  gcq [msg]    - Quick commit with auto-generated message"
    echo "  gshow        - Show commit diff interactively"
    echo
    echo "FILE MANAGEMENT:"
    echo "  ga-fzf       - Interactive git add with diff preview"
    echo "  greset-fzf   - Interactive unstage with preview"
    echo "  git-files    - Browse git log with file changes"
    echo
    echo "STASH MANAGEMENT:"
    echo "  gst-fzf      - Interactive stash manager (apply/pop/drop/show)"
    echo "  git-stash    - Step through stashes with actions"
    echo
    echo "WORKTREE MANAGEMENT:"
    echo "  gwt-new <branch> [path] - Create new worktree"
    echo "  gwt          - List and navigate worktrees"
}

show_tmux_aliases() {
    echo
    echo "==============================================="
    echo "              TMUX ALIASES"
    echo "==============================================="
    echo
    echo "BASIC COMMANDS:"
    echo "  t     - tmux"
    echo "  tn    - tmux new -s (new session)"
    echo "  tl    - tmux ls (list sessions)"
    echo "  ta    - tmux attach (with fzf selection)"
    echo "  tk    - tmux kill-session -t"
    echo "  tka   - tmux kill-server"
    echo "  td    - tmux detach"
    echo "  ts    - tmux switch -t"
}

show_tmux_functions() {
    echo
    echo "==============================================="
    echo "         TMUX INTERACTIVE FUNCTIONS"
    echo "==============================================="
    echo
    echo "SESSION MANAGEMENT:"
    echo "  tns [name]   - Create/attach session (default: current dir name)"
    echo "  ts-fzf       - Interactive session switcher with preview"
    echo "  tcd          - Create session in selected directory"
    echo "  tk-fzf       - Kill multiple sessions interactively"
    echo "  tr [name]    - Rename current session"
    echo "  tmux-rename  - Rename any session interactively"
    echo "  tmux-kill    - Kill session with confirmation"
    echo "  tmux-kill-hard - Kill session without confirmation"
    echo
    echo "WINDOW/PANE MANAGEMENT:"
    echo "  tw           - Quick window switcher with fzf"
    echo "  tmux-pane    - Navigate panes with preview"
    echo "  tmux-send-all <cmd> - Send command to all panes"
    echo
    echo "SESSION PERSISTENCE:"
    echo "  tmux-save [session] [file]    - Save session layout"
    echo "  tmux-restore [file]           - Restore session layout"
    echo
    echo "GIT INTEGRATION:"
    echo "  tgit         - Open git repo in tmux session"
    echo "  tgs          - Show git status in all tmux panes"
}

show_tmux_keybindings() {
    echo
    echo "==============================================="
    echo "           TMUX KEY BINDINGS"
    echo "==============================================="
    echo
    echo "PREFIX: Ctrl+a (changed from default Ctrl+b)"
    echo
    echo "PANE NAVIGATION (vim-style):"
    echo "  Ctrl+a h     - Move to left pane"
    echo "  Ctrl+a j     - Move to down pane"
    echo "  Ctrl+a k     - Move to up pane"
    echo "  Ctrl+a l     - Move to right pane"
    echo
    echo "PANE SPLITTING:"
    echo "  Ctrl+a |     - Split vertically"
    echo "  Ctrl+a -     - Split horizontally"
    echo
    echo "PANE RESIZING:"
    echo "  Ctrl+a H     - Resize pane left"
    echo "  Ctrl+a J     - Resize pane down"
    echo "  Ctrl+a K     - Resize pane up"
    echo "  Ctrl+a L     - Resize pane right"
    echo
    echo "WINDOW MANAGEMENT:"
    echo "  Ctrl+a c     - Create new window"
    echo "  Ctrl+a n     - Next window"
    echo "  Ctrl+a p     - Previous window"
    echo "  Ctrl+a [0-9] - Switch to window number"
    echo
    echo "OTHER:"
    echo "  Ctrl+a r     - Reload tmux config"
    echo "  Ctrl+a ?     - Show all keybindings"
    echo "  Ctrl+a d     - Detach from session"
    echo "  Ctrl+a [     - Enter copy mode (vim keys work)"
    echo "  Ctrl+a ]     - Paste from buffer"
}

show_menu() {
    echo "==============================================="
    echo "     GIT & TMUX COMMAND DISCOVERY TOOL"
    echo "==============================================="
    echo
    echo "What would you like to explore?"
    echo
    echo "1) Git aliases"
    echo "2) Git interactive functions"
    echo "3) Tmux aliases"
    echo "4) Tmux interactive functions"
    echo "5) Tmux key bindings"
    echo "6) Show all"
    echo "q) Quit"
    echo
    read -p "Enter your choice: " choice
    
    case $choice in
        1) clear; show_git_aliases ;;
        2) clear; show_git_functions ;;
        3) clear; show_tmux_aliases ;;
        4) clear; show_tmux_functions ;;
        5) clear; show_tmux_keybindings ;;
        6) clear
           show_git_aliases
           show_git_functions
           show_tmux_aliases
           show_tmux_functions
           show_tmux_keybindings
           ;;
        q|Q) exit 0 ;;
        *) echo "Invalid choice" ;;
    esac
    
    echo
    read -p "Press Enter to continue..."
    clear
    show_menu
}

# Check if running with an argument
if [ "$1" = "--all" ] || [ "$1" = "-a" ]; then
    show_git_aliases
    show_git_functions
    show_tmux_aliases
    show_tmux_functions
    show_tmux_keybindings
else
    show_menu
fi