Tmux: A Streamlined Guide to the Terminal Multiplexer

🔍 What Is Tmux?

Tmux is a terminal multiplexer: it lets you run multiple terminal sessions within a single terminal window. It's especially useful on remote servers over SSH or when multitasking with CLI tools.

Key Features:

Multiplex terminal windows into sessions, windows, and panes

Detach from a session and reattach later

Persistent remote work even if your connection drops

Great for scripting, automation, and custom workflows

🪧 Core Concepts

Term

Description

Client

The outer terminal from which you access tmux (e.g., your Mac/iTerm2 shell)

Session

A collection of windows, typically representing a workflow

Window

Like a tab: each can contain multiple panes

Pane

A split terminal view inside a window (horizontal or vertical)

Active Pane

The focused pane receiving input

Current Window

The visible window in the session

🌎 Starting and Managing Sessions

# Start tmux
$ tmux

# New named session
$ tmux new -s mysession

# Attach to existing session
$ tmux attach
$ tmux attach -t mysession

# List sessions
$ tmux ls

# Kill session
$ tmux kill-session -t mysession

# Detach (inside tmux)
Ctrl-b d

🌐 Navigation: Windows (Tabs)

Key Bind

Action

Ctrl-b c

New window

Ctrl-b ,

Rename window

Ctrl-b n / p

Next / Prev window

Ctrl-b w

Choose window

Ctrl-b &

Kill current window

🔹 Pane Management

Key Bind

Action

Ctrl-b %

Split pane vertically

Ctrl-b "

Split pane horizontally

Ctrl-b o

Switch to next pane

Ctrl-b ;

Switch to last active pane

Ctrl-b q

Show pane numbers

Ctrl-b x

Kill current pane

Resize with:

Ctrl-b :resize-pane -D 5  # Down
Ctrl-b :resize-pane -U 5  # Up
Ctrl-b :resize-pane -L 5  # Left
Ctrl-b :resize-pane -R 5  # Right

✅ Status Line Basics

The tmux status line is the bar at the bottom showing the current session, windows, and system time.

Customize it in ~/.tmux.conf:

set -g status on
set -g status-style bg=blue,fg=white
set -g status-left '[#S]'
set -g status-right '%H:%M %d-%b-%y'

⌘ Prefix Key

Most tmux commands start with a prefix key.

Default: Ctrl-b

To change to Ctrl-a (like GNU screen):

set -g prefix C-a
unbind C-b
bind C-a send-prefix

🎡 Copy Mode

Key Bind

Action

Ctrl-b [

Enter copy mode

Ctrl-b ]

Paste copied buffer

q

Exit copy mode

Arrow Keys

Move cursor

Space / Enter

Begin / end text selection

🎓 Tree Mode (Session/Window/Pane Navigator)

Key Bind

Description

Ctrl-b s

Browse sessions

Ctrl-b w

Browse windows

Enter

Switch to selection

q

Exit tree mode

🔢 Command Prompt

Invoke with:

Ctrl-b :     # Opens tmux prompt

Use it to run tmux commands like:

:neww top
:split-window -h

🌀 Zoom & Layouts

Key Bind

Action

Ctrl-b z

Zoom/unzoom current pane

Ctrl-b Space

Rotate layouts

Ctrl-b M-1

Apply even-horizontal layout

Ctrl-b M-2

Apply even-vertical layout

⚖️ Useful .tmux.conf Options

# Enable mouse support
set -g mouse on

# Use vi keys in copy mode
set -g mode-keys vi

# Show pane titles in border
set -g pane-border-status top
set -g pane-border-format '#[bold]#{pane_title}#[default]'

🤔 Still Confused?

Run man tmux for complete docs or visit:
https://github.com/tmux/tmux/wiki/Getting-Started

