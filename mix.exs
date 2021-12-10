defmodule Radixir.MixProject do
  use Mix.Project

  @source_url "https://github.com/radixir/radixir"
  @version "0.0.2"

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
      source_url: @source_url
    ]
  end

  def application() do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  defp deps() do
    [
      {:curvy, "~> 0.3.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:req, "~> 0.2.0"}
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
