# CTF-WorkspaceGen
This is a bash script created to automate the process of creating my CTF and Box workspace.

## Zshrc Required Changes
### Update ZSHRC
In order for the terminal title to stay changed the following conditional statement must be added to the precmd() function:
```zsh
precmd() {
    # Check if the MY_FIXED_TITLE environment variable is set
    if [[ -n $MY_FIXED_TITLE ]]; then
        # add new line
        echo     
    
        # If it is set, exit this function early to avoid changing the title
        return
    fi
    
    # Otherwise, existing commands that set the terminal title
}
```
### Source Zshrc
```zsh
source ~/.zshrc
```

