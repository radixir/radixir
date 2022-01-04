import Config

config :radixir, Radixir.Config,
  radix_gateway_api_url: System.fetch_env!("RADIX_GATEWAY_API_URL"),
  radix_core_api_url: System.fetch_env!("RADIX_CORE_API_URL")
