import Config

config :radixir,
  radix_node_url: System.fetch_env!("RADIX_NODE_URL"),
  private_keys: System.fetch_env!("PRIVATE_KEYS"),
  radix_testnet: System.fetch_env!("RADIX_TESTNET")
