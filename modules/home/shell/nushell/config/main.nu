
use std

source ~/.config/nushell/aliases.nu
source ~/.config/nushell/functions.nu
use jc-functions *
source ~/.config/nushell/keybindings.nu

let carapace_completer = {|spans|
  carapace $spans.0 nushell $spans | from json
}

$env.config = {
  use_grid_icons: true
  footer_mode: "25"
  float_precision: 2
  use_ansi_coloring: true
  edit_mode: vi
  shell_integration: true
  show_banner: false
  render_right_prompt_on_last_line: true
  history: {
    max_size: 10000
    sync_on_enter: true
    file_format: "plaintext"
  }

  ls: {
    use_ls_colors: true
    clickable_links: true
  }

  completions: {
    case_sensitive: false
    quick: true  # set this to false to prevent auto-selecting completions when only one remains
    partial: true  # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"  # prefix, fuzzy
    external: {
        enable: true
        completer: $carapace_completer
        max_results: 100
    }
  }

  table: {
    mode: rounded
    index_mode: auto
    trim: {
      methodology: wrapping,
      wrapping_try_keep_words: true,
    }
  }

  hooks: {
    pre_prompt: [{ ||
      let direnv = (direnv export json | from json | default {})
      if ($direnv | is-empty) {
          return
      }
      $direnv
      | items {|key, value|
         {
            key: $key
            value: (if $key in $env.ENV_CONVERSIONS {
              do ($env.ENV_CONVERSIONS | get $key | get from_string) $value
            } else {
                $value
            })
          }
      } | transpose -ird | load-env
    }]
    pre_execution: [{
      $nothing  # replace with source code to run before the repl input is run
    }]
    env_change: {
      PWD: [{|before, after|
        $nothing  # replace with source code to run if the PWD environment is different since the last repl input
      }]
    }
  }

  menus: [
    {
      name: completion_menu
      only_buffer_difference: false
      marker: "| "
      type: {
          layout: columnar
          columns: 4
          col_width: 20
          col_padding: 2
      }
      style: {
          text: white
          selected_text: white_reverse
          description_text: yellow
      }
    }
    {
      name: help_menu
      only_buffer_difference: true
      marker: "? "
      type: {
          layout: description
          columns: 4
          col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
          col_padding: 2
          selection_rows: 4
          description_rows: 10
      }
      style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
      }
    }
    {
      name: commands_menu
      only_buffer_difference: false
      marker: "# "
      type: {
          layout: columnar
          columns: 4
          col_width: 20
          col_padding: 2
      }
      style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
      }
      source: { |buffer, position|
          $nu.scope.commands
          | where command =~ $buffer
          | each { |it| {value: $it.command description: $it.usage} }
      }
    }
    {
      name: vars_menu
      only_buffer_difference: true
      marker: "# "
      type: {
          layout: list
          page_size: 10
      }
      style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
      }
      source: { |buffer, position|
          $nu.scope.vars
          | where name =~ $buffer
          | sort-by name
          | each { |it| {value: $it.name description: $it.type} }
      }
    }
    {
      name: commands_with_description
      only_buffer_difference: true
      marker: "# "
      type: {
          layout: description
          columns: 4
          col_width: 20
          col_padding: 2
          selection_rows: 4
          description_rows: 10
      }
      style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
      }
      source: { |buffer, position|
          $nu.scope.commands
          | where command =~ $buffer
          | each { |it| {value: $it.command description: $it.usage} }
      }
    }
  ]
  keybindings: $keybindings
}
