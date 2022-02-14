import Config

config :radixir, Radixir.Config,
  gateway_api_url: System.get_env("GATEWAY_API_URL"),
  core_api_url: System.get_env("CORE_API_URL"),
  system_api_url: System.get_env("SYSTEM_API_URL"),
  testnet: System.get_env("TESTNET"),
  usernames: System.get_env("USERNAMES"),
  passwords: System.get_env("PASSWORDS")
