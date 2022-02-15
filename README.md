# Cablegram

Telegram Bot library for the Elixir language

## About

This is not an official library by the authors of the Telegram application.

Goals:

* provide a reasonably complete implementation faithful to the Telegram Bot API
* be extensible without having to fork or vendor the library: components can be
  exchanged and the original implementation re-used and adapted
* be simple to extend when easy changes to the Telegram Bot API occur: most
  changes should be matched easily in the code, so just open a pull request!

## Installation

Add it to your dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cablegram, "~> 0.1.0"}
  ]
end
```

## Usage

See <https://hexdocs.pm/cablegram/Cablegram.html>
