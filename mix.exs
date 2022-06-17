defmodule Cablegram.MixProject do
  use Mix.Project

  def project do
    [
      app: :cablegram,
      version: "0.2.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Cablegram",
      description: "Telegram Bot library for the Elixir language",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ],
      package:  [
        files: ["lib", "mix.exs", "README*", "LICENSE*"],
        licenses: ["AGPL-3.0-or-later"],
        links: %{"GitHub" => "https://github.com/schnittchen/cablegram"},
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.3.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
