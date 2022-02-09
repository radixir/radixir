defmodule Radixir do
  alias Radixir.Core.DeriveEntityIdentifier
  alias Radixir.Util

  def derive_entity_identifier() do
    []
    |> DeriveEntityIdentifier.network_identifier(network: "mainnet")
    |> DeriveEntityIdentifier.public_key(
      hex: "0276652d0e13c3f8733cd92cc487b66a2ea900754e624077241965497763c1db96"
    )
    |> DeriveEntityIdentifier.Metadata.PreparedStakes.type()
    |> DeriveEntityIdentifier.Metadata.PreparedStakes.validator(
      address: "rdx1qsp8vefdpcfu87rn8nvje3y8ke4za2gqw48xysrhysvk2jthv0qah9shn6ser"
    )
    |> DeriveEntityIdentifier.Metadata.PreparedStakes.sub_entity(
      address: "rdx1qspfwatx9gl6k2j5063thkcwtyajv2w8z29pfuzzl5rynymm9p3ggrsqss2vv",
      validator_address: "rdx1qspyekyu6xzyhuznlap0me5exzhf4aa32hv83766l8h5hfnl5c3umlc2txzzs",
      epoch_unlock: 300
    )
    |> Util.stitch()
  end
end
