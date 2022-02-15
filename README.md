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

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cablegram` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cablegram, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/cablegram>.

