let main_keybinds = [
  {
    name: completion_menu
    modifier: none
    keycode: tab
    mode: [emacs vi_normal vi_insert]
    event: {
      until: [
        { send: menu name: completion_menu }
        { send: menunext }
      ]
    }
  }
  {
    name: completion_previous
    modifier: shift
    keycode: backtab
    mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
    event: { send: menuprevious }
  }
  {
    name: next_page
    modifier: control
    keycode: char_x
    mode: emacs
    event: { send: menupagenext }
  }
  {
    name: undo_or_previous_page
    modifier: control
    keycode: char_z
    mode: emacs
    event: {
      until: [
        { send: menupageprevious }
        { edit: undo }
      ]
     }
  }
  {
    name: yank
    modifier: control
    keycode: char_y
    mode: emacs
    event: {
      until: [
        {edit: pastecutbufferafter}
      ]
    }
  }
  {
    name: unix-line-discard
    modifier: control
    keycode: char_u
    mode: [emacs, vi_normal, vi_insert]
    event: {
      until: [
        {edit: cutfromlinestart}
      ]
    }
  }
  {
    name: kill-line
    modifier: control
    keycode: char_k
    mode: [emacs, vi_normal, vi_insert]
    event: {
      until: [
        {edit: cuttolineend}
      ]
    }
  }
  # Keybindings used to trigger the user defined menus
  {
    name: commands_menu
    modifier: control
    keycode: char_t
    mode: [emacs, vi_normal, vi_insert]
    event: { send: menu name: commands_menu }
  }
  {
    name: vars_menu
    modifier: alt
    keycode: char_o
    mode: [emacs, vi_normal, vi_insert]
    event: { send: menu name: vars_menu }
  }
  {
    name: commands_with_description
    modifier: control
    keycode: char_s
    mode: [emacs, vi_normal, vi_insert]
    event: { send: menu name: commands_with_description }
  }
  {
    name: skim_history
    modifier: control
    keycode: char_r
    mode: [emacs, vi_normal, vi_insert]
    event: {
      send: executehostcommand
      cmd: "commandline (history | each { |it| $it.command} | uniq | reverse | str join (char nl) | fzf --layout=reverse --height=40%)"
    }
  }
]

let auto_pair_keybinds = [
  {
    name: "paren"
    left: "("
    right: ")"
  }
  {
    name: "curly_bracket"
    left: "{"
    right: "}"
  }
  {
    name: "bracket"
    left: "["
    right: "]"
  }
  {
    name: "arrow"
    left: "<"
    right: ">"
  }
  {
    name: "quote"
    left: '"'
    right: '"'
  }
  {
    name: "single_quote"
    left: "'"
    right: "'"
  }
]

let keybindings = $main_keybinds ++ (
  $auto_pair_keybinds | each {|k| {
    name: $"autopair_($k.name)"
    modifier: none
    keycode: $"char_($k.left)"
    mode: [emacs, vi_normal, vi_insert]
    event: [
      { edit: InsertChar value: $k.left }
      { edit: InsertChar value: $k.right },
      { edit: MoveLeft }
    ]
  }}
)
