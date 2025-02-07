def main [] {
    let tabs = zellij action dump-layout | parse -r "tab name=\"(.*)\"" | get capture0
    let selected_tab = $tabs | to text | gum filter
    let index = $tabs | enumerate | where item == $selected_tab | get 0.index
    zellij action go-to-tab ($index + 1)
}
