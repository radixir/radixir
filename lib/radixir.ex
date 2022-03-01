defmodule Radixir do
  alias BlockKeys.Encoding
  alias Radixir.Util

  def go do
    root_key =
      BlockKeys.from_mnemonic(
        "nurse grid sister metal flock choice system control about mountain sister rapid hundred render shed chicken print cover tape sister zero bronze tattoo stairs"
      )

    master_private_key = BlockKeys.CKD.derive(root_key, "m/44'/1022'/0'")
    master_public_key = BlockKeys.CKD.derive(root_key, "M/44'/1022'/0'")

    private_key =
      BlockKeys.CKD.derive(master_private_key, "m/0/0")
      |> Encoding.decode_extended_key()
      |> Map.fetch!(:key)
      |> Util.encode16()
      |> String.replace_prefix("00", "")

    public_key =
      BlockKeys.CKD.derive(master_public_key, "M/0/0")
      |> Encoding.decode_extended_key()
      |> Map.fetch!(:key)
      |> Util.encode16()
      |> String.replace_prefix("00", "")

    %{
      private_key: private_key,
      public_key: public_key,
      master_private_key: master_private_key,
      master_public_key: master_public_key
    }
  end
end
