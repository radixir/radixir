defmodule Radixir.MixProject do
  use Mix.Project

  @source_url "https://github.com/radixir/radixir"
  @version "0.0.2"

  def project do
    [
      app: :radixir,
      version: @version,
      elixir: "~> 1.13.0-rc.1",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: @source_url
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:req, "~> 0.2.0"},
      {:uuid, "~> 1.1"}
    ]
  end

  defp description() do
    """
    An Elixir wrapper for Radix APIs and functionality.
    """
  end

  defp package() do
    [
      maintainers: ["Jon-Eric Cook"],
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE CHANGELOG.md),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end
end
