defmodule Beaker.Mixfile do
  use Mix.Project

  def project do
    [
      app: :beaker,
      version: "1.1.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: compilers(Mix.env),
      name: "beaker",
      description: description,
      package: package,
      source_url: "https://github.com/hahuang65/beaker",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  def application do
    [
      applications: apps(Mix.env),
      mod: {Beaker, []}
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp apps(_), do: apps
  defp apps do
    [:logger]
  end

  # Need phoenix compiler to compile our views.
  defp compilers(:test) do
    [:phoenix | compilers]
  end
  defp compilers(_) do
    if Code.ensure_loaded?(Phoenix.HTML) do
      [:phoenix | compilers]
    else
      compilers
    end
  end
  defp compilers do
    Mix.compilers
  end

  defp deps do
    [
      {:phoenix, "~> 1.0", optional: true},
      {:ecto, ">= 0.15.0", optional: true},
      {:phoenix_ecto, "~> 1.2", only: :test},
      {:phoenix_html, "~> 2.2", only: :test},
      {:earmark, "~> 0.1", only: :docs},
      {:ex_doc, "~> 0.9", only: :docs},
      {:inch_ex, only: :docs}
    ]
  end

  defp description do
    """
    Measure your Elixir!

    A metrics library that will help Elixirists keep track of their application's performance, as well as any custom statistics they like.
    """
  end

  defp package do
    [
      contributors: ["Howard Huang"],
      links: %{
        "GitHub" => "http://github.com/hahuang65/beaker",
        "Docs" => "http://hexdocs.pm/beaker/"
      }
    ]
  end
end
