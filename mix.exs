defmodule Radixir.MixProject do
  use Mix.Project

  @source_url "https://github.com/radixir/radixir"
  @version "0.0.4"

  def project() do
    [
      app: :radixir,
      version: @version,
      elixir: "~> 1.13",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application() do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  defp deps() do
    [
      {:block_keys, "~> 0.1.10"},
      {:curvy, "~> 0.3.0"},
      {:decimal, "~> 2.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:mox, "~> 1.0", only: :test},
      {:nimble_options, "~> 0.3.0"},
      {:req, "~> 0.2.0"},
      {:scrypt, "~> 2.1"}
    ]
  end

  defp description() do
    """
    Radix + Elixir
    """
  end

  def docs() do
    [
      main: "readme",
      name: "Radixir",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/radixir",
      source_url: @source_url,
      extras: ["README.md", "CHANGELOG.md", "LICENSE"]
    ]
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
