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
end
