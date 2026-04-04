# GMC Keyboard Layout Instructions

The GMC keyboard bundle provides a layout for programmers who work in a
multilingual environment who wish to avoid dead-keys on backticks, apostrophes,
commas, and double-quotes. The dead-keys are activated only with the right-alt
modifier, also known as AltCar or AltGr.

The layout also provides box art shortcuts, arrows, and basic logic symbols. It
should not interfere with _vi_, _vim_, or _neovim_ so long as the programmer use
the left-control for commands and right-control for box and logic symbols. There
are eight layouts:

<!-- toc -->

## 1. Diacritic Guide

Canadians will notice the inspiration of the CSA keyboard, with some
alterations. Language priority is my own.

### 1.1 Single-stroke diacritics

| Symbol      | Combination            |
| ----------- | ---------------------- |
| à           | AltGr + \ (backslash)  |
| è           | AltGr + ' (apostrophe) |
| ù           | <> (ISO key)           |
| é           | AltGr + / (slash)      |
| ă (a-breve) | AltGr + a              |
| ẞ (esszed)  | AltGr + s              |
| ç           | AltGr + c              |
| ñ           | AltGr + n              |
| ț (tz)      | AltGr + t              |
| ș (sh)      | AltGr + h              |

Capitals are available, just add Shift to AltGr.

#### 1.1.1 North Americans and Ù

Those using an ANSI keyboard, that is to say the majority of English Canadians
and Americans, will need to use the grave dead-key combination followed by "u"
to get ù. However, ZSA users using the "GMC" Moonlander or Voyager layouts are
good to go.

### 1.2 Dead-keys

| Dead-key       | Combination           |
| -------------- | --------------------- |
| \` (grave)     | AltGr + \` (backtick) |
| ¨ (diaeresis)  | AltGr + u             |
| ^ (circumflex) | AltGr + i             |
| ´ (acute)      | AltGr + o             |

There is no cedilla dead-key unless I receive requests.

### 1.3 Punctuation and Currency

| Symbol              | Combination            |
| ------------------- | ---------------------- |
| ¡                   | AltGr + 1 or AltGr + q |
| ¿                   | AltGr + 2 or AltGr + w |
| « (left guillemet)  | AltGr + z              |
| » (right guillemet) | AltGr + x              |
| € (Euro)            | AltGr + e              |
| £ (Pound Sterling)  | AltGr + l              |
| ¥ (Yen)             | AltGr + y              |

## 2. Box-Art and Logic Symbols

All the symbols use the right-control modifier.

### 2.1 Box Art

Box art is restricted to the left half of the keyboard. I will use QWERTY to
describe the locations, but Tarmak and Colemak users should note that the box
art symbols are linked to the _physical_ location. For example, the box art
symbol `┤` is activated by `RCtrl + y` in QWERTY. It is activated in Colemak
with `RCtrl + b`. Colemak's _B_ is located in the space occupied by QWERTY's
_Y_.

| Row | Symbols   | QWERTY    |
| --- | --------- | --------- |
| 4   | ╭ ┌ ─ ┐ ╮ | 1 2 3 4 5 |
| 3   | ├ │ ┼ │ ┤ | q w e r t |
| 2   | ╰ └ ─ ┘ ╯ | a s r d f |
| 1   | ┬ ┴       | x c       |

### 2.2 Logic

The logic symbols are not available to ZSA GMC 1 layouts. They are available
for ZSA GMC 2.x layouts.

Once again, I will use QWERTY to describe the positions of the symbols.

| Row | Symbols       | QWERTY              |
| --- | ------------- | ------------------- |
| 4   | ¬ ∧ ∨ ⊕ ∴ ∵ ≡ | 6 7 8 9 0 - =       |
| 3   | ∀ ∃ ⇔ ⊤ ⊥     | y u i o p           |
| 2   | ← ↓ ↑ → ⇒     | h j k l ;           |
| 1   | □ ◇           | shift + , shift + . |

As an aid to memory, `∧` (conjunction/AND) is the same key as `&`. The arrows
follow _vi_'s cursor keys.

### 2.3 Miscellaneous

These symbols are not available to ZSA GMC 1 layouts. They are available for ZSA
GMC 2.x layouts.

| Row | Symbols    | QWERTY    |
| --- | ---------- | --------- |
| 1   | 🎵 ✓ ✗ ☐ ☑ | z n m , . |

## 3. Installation

### 3.1 Local (User) Installation

```sh
mkdir -p $XDG_CONFIG_HOME/xkb/{rules,symbols}
cp rules/evdev.xml $XDG_CONFIG_HOME/xkb/rules
cp symbols/* $XDG_CONFIG_HOME/xkb/symbols
```

### 3.2 System Configuration

1. Copy `rules/evdev_snippet` into the clipboard
2. As root, edit `/usr/share/X11/xkb/rules/evdev.xml` and insert the contents of
   the clipboard into the bottom of the `<layoutList>` element.

## 4. Use

There are eight variants to the GMC layout. Here are their use cases:

| Layout | Variant    | Use Case                                                                          |
| ------ | ---------- | --------------------------------------------------------------------------------- |
| gmc    | gmc        | US non-extended keyboard for multilingual programmers                             |
| gmc    | zsa        | All ZSA "GMC 2.0" layouts                                                         |
| gmc    | us         | US keyboard for multilingual programmers, no logic symbols, ZSA "GMC 1.0" layouts |
| gmc    | colemak-dh | Colemak DHm variant for non-ZSA keyboards                                         |
| gmc    | tarmak1    | Tarmak Level One for Colemak DHm                                                  |
| gmc    | tarmak2    | Tarmak Level Two for Colemak DHm                                                  |
| gmc    | tarmak3    | Tarmak Level Three for Colemak DHm                                                |
| gmc    | tarmak4    | Tarmak Level Four for Colemak DHm                                                 |

### 4.1 KDE and Gnome

KDE and Gnome users can select the keyboards using the system settings GUI.

### 4.2 Hyprland

Hyprland users will want to set the keyboard in `.config/hypr/hyprland.conf`:

```txt
input {

    kb_layout = gmc
    kb_variant = <variant>

    ...
}
```

## 5. Note on ZSA Layout Decisions

The "GMC 2.0" keyboard layouts hosted by ZSA "Oryx" are meant to work with both
Linux and macOS. As I am advised that using a separate right-control on macOS
is subject to error, I had to be imaginative in arranging the special
characters. As a result, the CSA layout for ¡ and ¿ had to move down one row.
