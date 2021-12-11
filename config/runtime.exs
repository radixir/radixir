import Config

config :radixir, Radixir.Config,
  radix_node_url: System.fetch_env!("RADIX_NODE_URL"),
  keypairs_file_name: System.get_env("KEYPAIRS_FILE_NAME", "keypairs")
