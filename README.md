# Radixir

Radix + Elixir

## Installation

The package can be installed by adding `radixir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:radixir, "~> 0.0.5"}
  ]
end
```

## Documentation

Check out the docs here [https://hexdocs.pm/radixir](https://hexdocs.pm/radixir).

## Environment variables

See `.envrc.example` for an example of what environment variables can be set. Note that Radixir can still be used even if no environment variables are set.

## Configuration

Place the following in `runtime.exs` if using environment variables:

```
config :radixir, Radixir.Config,
  gateway_api_url: System.get_env("GATEWAY_API_URL"),
  core_api_url: System.get_env("CORE_API_URL"),
  system_api_url: System.get_env("SYSTEM_API_URL"),
  testnet: System.get_env("TESTNET"),
  usernames: System.get_env("USERNAMES"),
  passwords: System.get_env("PASSWORDS")

```

The following will need to be set in `config.exs` or `runtime.exs`:

```
config :block_keys, :ec_module, :libsecp256k1
```

## Getting started locally

- Install [asdf](https://asdf-vm.com/guide/getting-started.html#_3-install-asdf)
- Clone [radixir](https://github.com/radixir/radixir) repo
- Run `asdf install` while in `radixir` directory
- Run `iex -S mix` to start using `radixir`

## Example Usage

Usage examples can be found in `/lib/examples`.

## Github

[Radixir](https://github.com/radixir/radixir)

## License

Radixir is released under the Apache License 2.0 - see the [LICENSE](LICENSE) file.
