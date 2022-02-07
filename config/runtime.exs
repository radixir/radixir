import Config

config :radixir, Radixir.Config,
  radix_gateway_api_url: System.get_env("RADIX_GATEWAY_API_URL"),
  radix_core_api_url: System.get_env("RADIX_CORE_API_URL"),
  radix_system_api_url: System.get_env("RADIX_SYSTEM_API_URL"),
  radix_testnet: System.get_env("RADIX_TESTNET"),
  radix_usernames: System.get_env("RADIX_USERNAMES"),
  radix_passwords: System.get_env("RADIX_PASSWORDS")
