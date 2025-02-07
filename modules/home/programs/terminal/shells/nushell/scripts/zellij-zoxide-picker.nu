def main [] {
    let dir = zoxide query -l | gum filter --limit=1
    let name = $dir | path split | last
    zellij action new-tab --cwd=$"($dir)/" --layout=default -n $name
}
