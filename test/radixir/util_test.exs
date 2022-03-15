defmodule Radixir.UtilTest do
  use ExUnit.Case, async: true
  doctest Radixir.Util

  alias Radixir.Util

  describe "encrypt_message/3" do
    test "encrypt a message" do
      %{private_key: private_key_1} = Radixir.Key.generate()

      %{mainnet: %{account_address: account_address_2}} = Radixir.Key.generate()

      message = "hello there"
      assert {:ok, _} = Util.encrypt_message(message, private_key_1, account_address_2)
    end

    test "catches private_key that contains non hexadecimal digitis" do
      private_key = "79271eb15d58259ca1d58e8c49db2c208fa4b17e6e48c2ab2c3610855e4d747g"
      account_address = "rdx1qsp8aa6y6cgvuxqxgn2cm5q7jn7ng6ppdhye9npwpkcfvxtnlf4l2csqf5dvh"
      message = "hello there"

      assert {:error, "private_key must only have hexadecimal digits"} =
               Util.encrypt_message(message, private_key, account_address)
    end

    test "catches private_key that is too long" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc344"
      account_address = "rdx1qsp8aa6y6cgvuxqxgn2cm5q7jn7ng6ppdhye9npwpkcfvxtnlf4l2csqf5dvh"
      message = "hello there"

      assert {:error, "private_key must be 64 characters long"} =
               Util.encrypt_message(message, private_key, account_address)
    end

    test "catches address that has non alpha num character in it" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "rdx1qsp8aa6y6cgvuxqxgn2cm5q7jn7ng6ppdhye9npwpkcfvxtnlf4l2csqf5dv."
      message = "hello there"

      assert {:error, "address must only have alpha numeric characters"} =
               Util.encrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong prefix" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "fdx1qsp8aa6y6cgvuxqxgn2cm5q7jn7ng6ppdhye9npwpkcfvxtnlf4l2csqf5dv"
      message = "hello there"

      assert {:error, "address must start with rdx, tdx, rv, tv, rn or tn"} =
               Util.encrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - rdx" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "rdx1qsp8aa6y6cgvuxqxgn2cm5q7jn7ng6ppdhye9npwpkcfvxtnlf4l2csqf5dvhh"
      message = "hello there"

      assert {:error, "account address must be 65 characters long"} =
               Util.encrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - tdx" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "tdx1qspycakrstk7h5kxj5e5e2areycqnf5l39wzfhthcyshud9lh6mktvcvc83pkk"
      message = "hello there"

      assert {:error, "account address must be 65 characters long"} =
               Util.encrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - rv" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "rv1qfx8dsuzah4a9354xdx2hg7fxqy6d8uftsjd6a7py9lrf0a7kajmxz0rdrtt"
      message = "hello there"

      assert {:error, "validator address must be 62 characters long"} =
               Util.encrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - tv" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "tv1qfx8dsuzah4a9354xdx2hg7fxqy6d8uftsjd6a7py9lrf0a7kajmxykytvuu"
      message = "hello there"

      assert {:error, "validator address must be 62 characters long"} =
               Util.encrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - rn" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "rn1qfx8dsuzah4a9354xdx2hg7fxqy6d8uftsjd6a7py9lrf0a7kajmx6ufa044"
      message = "hello there"

      assert {:error, "node address must be 62 characters long"} =
               Util.encrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - tn" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "tn1qfx8dsuzah4a9354xdx2hg7fxqy6d8uftsjd6a7py9lrf0a7kajmxu9wmqzz"
      message = "hello there"

      assert {:error, "node address must be 62 characters long"} =
               Util.encrypt_message(message, private_key, account_address)
    end
  end

  describe "decrypt_message/3" do
    test "decrypt a message" do
      %{mainnet: %{account_address: account_address_1}, private_key: private_key_1} =
        Radixir.Key.generate()

      %{mainnet: %{account_address: account_address_2}, private_key: private_key_2} =
        Radixir.Key.generate()

      message = "hello there"

      {:ok, encrypted_message} = Util.encrypt_message(message, private_key_1, account_address_2)

      assert {:ok, message} ==
               Util.decrypt_message(encrypted_message, private_key_2, account_address_1)
    end

    test "catches private_key that contains non hexadecimal digitis" do
      private_key = "79271eb15d58259ca1d58e8c49db2c208fa4b17e6e48c2ab2c3610855e4d747g"
      account_address = "rdx1qsp8aa6y6cgvuxqxgn2cm5q7jn7ng6ppdhye9npwpkcfvxtnlf4l2csqf5dvh"
      message = "hello there"

      assert {:error, "private_key must only have hexadecimal digits"} =
               Util.decrypt_message(message, private_key, account_address)
    end

    test "catches private_key that is too long" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc344"
      account_address = "rdx1qsp8aa6y6cgvuxqxgn2cm5q7jn7ng6ppdhye9npwpkcfvxtnlf4l2csqf5dvh"
      message = "hello there"

      assert {:error, "private_key must be 64 characters long"} =
               Util.decrypt_message(message, private_key, account_address)
    end

    test "catches address that has non alpha num character in it" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "rdx1qsp8aa6y6cgvuxqxgn2cm5q7jn7ng6ppdhye9npwpkcfvxtnlf4l2csqf5dv."
      message = "hello there"

      assert {:error, "address must only have alpha numeric characters"} =
               Util.decrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong prefix" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "fdx1qsp8aa6y6cgvuxqxgn2cm5q7jn7ng6ppdhye9npwpkcfvxtnlf4l2csqf5dv"
      message = "hello there"

      assert {:error, "address must start with rdx, tdx, rv, tv, rn or tn"} =
               Util.decrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - rdx" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "rdx1qsp8aa6y6cgvuxqxgn2cm5q7jn7ng6ppdhye9npwpkcfvxtnlf4l2csqf5dvhh"
      message = "hello there"

      assert {:error, "account address must be 65 characters long"} =
               Util.decrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - tdx" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "tdx1qspycakrstk7h5kxj5e5e2areycqnf5l39wzfhthcyshud9lh6mktvcvc83pkk"
      message = "hello there"

      assert {:error, "account address must be 65 characters long"} =
               Util.decrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - rv" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "rv1qfx8dsuzah4a9354xdx2hg7fxqy6d8uftsjd6a7py9lrf0a7kajmxz0rdrtt"
      message = "hello there"

      assert {:error, "validator address must be 62 characters long"} =
               Util.decrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - tv" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "tv1qfx8dsuzah4a9354xdx2hg7fxqy6d8uftsjd6a7py9lrf0a7kajmxykytvuu"
      message = "hello there"

      assert {:error, "validator address must be 62 characters long"} =
               Util.decrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - rn" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "rn1qfx8dsuzah4a9354xdx2hg7fxqy6d8uftsjd6a7py9lrf0a7kajmx6ufa044"
      message = "hello there"

      assert {:error, "node address must be 62 characters long"} =
               Util.decrypt_message(message, private_key, account_address)
    end

    test "catches address that has wrong length - tn" do
      private_key = "519b6c5c1db1fab3e8513ad18b419082c81844ef66b24f850f9ab7366f7efc34"
      account_address = "tn1qfx8dsuzah4a9354xdx2hg7fxqy6d8uftsjd6a7py9lrf0a7kajmxu9wmqzz"
      message = "hello there"

      assert {:error, "node address must be 62 characters long"} =
               Util.decrypt_message(message, private_key, account_address)
    end
  end

  describe "encode_message/1" do
    test "encode a message" do
      assert "000068656c6c6f207468657265" == Util.encode_message("hello there")
      assert String.starts_with?("000068656c6c6f207468657265", "0000") == true
    end
  end

  describe "decode_message/1" do
    test "decode a message with 0000 prefix" do
      assert {:ok, "hello there"} == Util.decode_message("000068656c6c6f207468657265")
    end

    test "decode a message with 30303030 prefix" do
      assert {:ok, "hello there"} ==
               Util.decode_message("3030303036383635366336633666323037343638363537323635")
    end

    test "catches failure to decode message" do
      assert {:error, "could not base16 decode message"} = Util.decode_message("0000zzz")
    end

    test "catches failure to decode message due to invalid prefix" do
      assert {:error, "invalid message format"} = Util.decode_message("zzz")
    end
  end

  describe "verify_hash/2" do
    test "verify hash" do
      unsigned_transaction = Radixir.Util.encode16("hello there")

      assert :ok ==
               Util.verify_hash(
                 unsigned_transaction,
                 "56571a1be3fbeab18d215f549095915a004b5788ca0d535be668559129a76f25"
               )
    end

    test "catches failure to verify hash due to not being able to decode unsigned_transaction" do
      assert {:error, "could not base16 decode unsigned_transaction"} =
               Util.verify_hash(
                 "zzzz",
                 "56571a1be3fbeab18d215f549095915a004b5788ca0d535be668559129a76f25"
               )
    end
  end

  describe "xrd_to_atto/1" do
    test "convert xrd to atto with decimal" do
      assert "1500000000000000000" == Util.xrd_to_atto("1.5")
    end

    test "convert xrd to atto with no decimal" do
      assert "15000000000000000000" == Util.xrd_to_atto("15")
    end

    test "convert smallest xrd to atto with no decimal" do
      assert "1" == Util.xrd_to_atto("0.000000000000000001")
    end

    test "convert xrd to atto and drops 19th decimal place" do
      assert "1500000000000000009" == Util.xrd_to_atto("1.5000000000000000098")
    end
  end

  describe "atto_to_xrd/1" do
    test "convert atto to xrd" do
      assert "1.5" == Util.atto_to_xrd("1500000000000000000")
    end

    test "convert atto to xrd and ignores decimals" do
      assert "1.5" == Util.atto_to_xrd("1500000000000000000.98")
    end

    test "convert single atto to xrd" do
      assert "0.000000000000000001" == Util.atto_to_xrd("1")
    end
  end

  describe "xrd_abs/1" do
    test "get absolute value of negative xrd amount" do
      assert "1.5" == Util.xrd_abs("-1.5")
    end

    test "get absolute value of positive xrd amount" do
      assert "1.5" == Util.xrd_abs("1.5")
    end

    test "get absolute value of negative xrd amount to 18th decimal" do
      assert "1.500000000000000009" == Util.xrd_abs("-1.5000000000000000098")
    end
  end

  describe "xrd_add/2" do
    test "adds two xrd amounts and drops 19th decimal place" do
      assert "24.000000000000000002" ==
               Util.xrd_add("12.0000000000000000014", "12.0000000000000000014")
    end

    test "adds two xrd amounts and drops 19th decimal place - use negative number" do
      assert "0.000000000000000000" ==
               Util.xrd_add("-12.0000000000000000014", "12.0000000000000000014")
    end

    test "adds two xrd amounts and drops 19th decimal place - use various decimal places" do
      assert "0.000999" ==
               Util.xrd_add("-12.000001", "12.001")
    end
  end

  describe "xrd_compare/2" do
    test "compares two xrd amounts and drops 19th decimal place - gt" do
      assert :gt == Util.xrd_compare("12.0000000000000000026", "12.0000000000000000014")
    end

    test "compares two xrd amounts and drops 19th decimal place - lt" do
      assert :lt == Util.xrd_compare("12.0000000000000000016", "12.0000000000000000024")
    end

    test "compares two xrd amounts and drops 19th decimal place - eq" do
      assert :eq == Util.xrd_compare("12.0000000000000000026", "12.0000000000000000024")
    end
  end
end
