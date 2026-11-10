# ~/.config/doti3/zsh/conf.d/07-worktrees.zsh
# Git Worktree Helpers (Optimized for AI Agents & Parallel Branching)

# 1. Create & Switch to Worktree: gwa <branch-name> [base-branch]
gwa() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a git repository." >&2
    return 1
  fi

  if [ -z "$1" ]; then
    echo "Usage: gwa <branch-name> [base-branch]" >&2
    return 1
  fi

  local branch="$1"
  local base="${2:-}"
  local main_dir
  main_dir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null | sed 's/\/.git$//') || main_dir=$(git rev-parse --show-toplevel)
  local repo_name
  repo_name=$(basename "$main_dir")
  local target_dir="${main_dir}/../${repo_name}-${branch//\//-}"

  if git show-ref --verify --quiet "refs/heads/$branch"; then
    git worktree add "$target_dir" "$branch"
  elif git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
    git worktree add --track -b "$branch" "$target_dir" "origin/$branch"
  else
    if [ -n "$base" ]; then
      git worktree add -b "$branch" "$target_dir" "$base"
    else
      git worktree add -b "$branch" "$target_dir"
    fi
  fi

  if [ -d "$target_dir" ]; then
    cd "$target_dir" || return 1
    echo "Switched to worktree: $target_dir ($branch)"
  fi
}

# 2. Interactive Worktree Switcher: gws
gws() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a git repository." >&2
    return 1
  fi

  local selected
  selected=$(git worktree list | fzf --reverse --prompt="Git Worktree > " --height=35% --border=rounded)
  if [ -n "$selected" ]; then
    local target
    target=$(echo "$selected" | awk '{print $1}')
    if [ -d "$target" ]; then
      cd "$target" || return 1
    fi
  fi
}

# 3. Jump to Main/Common Worktree Root: gwm
gwm() {
  local main_dir
  main_dir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null | sed 's/\/.git$//') || main_dir=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ -n "$main_dir" ] && [ -d "$main_dir" ]; then
    cd "$main_dir" || return 1
  else
    echo "Error: Could not resolve main git directory." >&2
    return 1
  fi
}

# 4. Remove Current Worktree & Return to Main: gwr
gwr() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a git repository." >&2
    return 1
  fi

  local current_dir
  current_dir=$(pwd -P)
  local main_dir
  main_dir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null | sed 's/\/.git$//') || main_dir=$(git rev-parse --show-toplevel)

  if [ "$current_dir" = "$main_dir" ]; then
    echo "Cannot remove the main worktree ($main_dir)." >&2
    return 1
  fi

  echo "Removing worktree $current_dir..."
  cd "$main_dir" || return 1
  git worktree remove "$current_dir" --force
  git worktree prune
  echo "Removed worktree and returned to main repo."
}
