# Get the root configuration object
c = get_config()

c.InteractiveShell.autoindent = True
c.InteractiveShell.highlighting_style = "monokai"
c.InteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.auto_match = True

c.InteractiveShellApp.exec_lines.append("%load_ext autoreload")
c.InteractiveShellApp.exec_lines.append("%autoreload 2")

c.Completer.use_jedi = True
c.PlainTextFormatter.pprint = True
c.InteractiveShellApp.exec_lines = [
    "import os, sys, json",
    "from pathlib import Path",
    "import requests",
]

c.TerminalInteractiveShell.editor = "nvim"
