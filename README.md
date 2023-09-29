#Necessary Tools
### Zsh -- this is the shell the script was created for
### xdotool -- launch keyboard shortcuts from the commandd line

# ZSHRC Configuration File Required Changes
## Update ZSHRC
In order for the terminal title to stay changed the following conditional statement must be added to the precmd()function:
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
## Source the Zshrc File
```zsh
source ~/.zshrc
```

