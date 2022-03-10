import Config

config :block_keys, :ec_module, :libsecp256k1

if config_env() == :dev || config_env() == :prod do
  config :radixir, Radixir.Config,
    gateway_api_url: System.get_env("GATEWAY_API_URL"),
    core_api_url: System.get_env("CORE_API_URL"),
    system_api_url: System.get_env("SYSTEM_API_URL"),
    testnet: System.get_env("TESTNET"),
    usernames: System.get_env("USERNAMES"),
    passwords: System.get_env("PASSWORDS"),
    mnemonic: System.get_env("MNEMONIC")
end

if config_env() == :test do
  config :radixir, Radixir.Config,
    gateway_api_url: "https://stokenet.radixdlt.com",
    core_api_url: "https://core.dev.com",
    system_api_url: "https://core.dev.com",
    testnet: "true",
    usernames: "admin, superadmin, metrics",
    passwords: "funny cats very Jack 21!, harry Kack love h39! LW, monitor Kat darrel 23 Jack!",
    mnemonic:
      "nurse grid sister metal flock choice system control about mountain sister rapid hundred render shed chicken print cover tape sister zero bronze tattoo stairs"
end
