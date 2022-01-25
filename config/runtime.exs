import Config

config :radixir, Radixir.Config,
  radix_gateway_api_url: System.fetch_env!("RADIX_GATEWAY_API_URL"),
  radix_core_api_url: System.fetch_env!("RADIX_CORE_API_URL"),
  radix_system_api_url: System.fetch_env!("RADIX_SYSTEM_API_URL"),
  radix_testnet: System.fetch_env!("RADIX_TESTNET"),
  radix_admin_password: System.fetch_env!("RADIX_ADMIN_PASSWORD"),
  radix_superadmin_password: System.fetch_env!("RADIX_SUPERADMIN_PASSWORD"),
  radix_metrics_password: System.fetch_env!("RADIX_METRICS_PASSWORD")
