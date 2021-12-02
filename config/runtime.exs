import Config

if config_env() == :test do
end

if config_env() == :dev || config_env() == :prod do
  config :radixir, Radixir.Config, radix_node_url: System.fetch_env!("RADIX_NODE_URL")
end

if config_env() == :dev do
end

if config_env() == :prod do
end
