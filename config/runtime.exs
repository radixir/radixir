import Config

config :radixir, Radixir.Config, radix_node_url: System.fetch_env!("RADIX_NODE_URL")
