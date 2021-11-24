defmodule Radixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :radixir,
      version: "0.0.1",
      elixir: "~> 1.13.0-rc.1",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Radixir",
      source_url: "https://github.com/radixir/radixir"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
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
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/radixir/radixir"}
    ]
  end
end
