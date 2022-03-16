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

  describe "xrd_div/2" do
    test "divides two xrd amounts and drops 19th decimal place - equals 1" do
      assert "1" == Util.xrd_div("12.0000000000000000026", "12.0000000000000000024")
    end

    test "divides two xrd amounts and drops 19th decimal place" do
      assert "1.999999999999999999" ==
               Util.xrd_div("24.0000000000000000036", "12.0000000000000000024")
    end

    test "divides two xrd amounts and drops 19th decimal place and results in smallest amount" do
      assert "0.000000000000000001" ==
               Util.xrd_div("1.0000000000000000026", "1000000000000000000.0000000000000000024")
    end
  end

  describe "xrd_div_int/2" do
    test "divides two xrd amounts and drops 19th decimal place and returns the integer part - equals 1" do
      assert "1" == Util.xrd_div_int("12.0000000000000000026", "12.0000000000000000024")
    end

    test "divides two xrd amounts and drops 19th decimal place and returns the integer part" do
      assert "1" ==
               Util.xrd_div_int("24.0000000000000000036", "12.0000000000000000024")
    end

    test "divides two xrd amounts and drops 19th decimal place and returns the integer part and results in zero" do
      assert "0" ==
               Util.xrd_div_int(
                 "1.0000000000000000026",
                 "1000000000000000000.0000000000000000024"
               )
    end
  end

  describe "xrd_div_rem/2" do
    test "divides two xrd amounts and drops 19th decimal place and returns the integer part and remainder part - equals 1" do
      assert {"1", "1"} == Util.xrd_div_rem("13.0000000000000000026", "12.0000000000000000024")
    end

    test "divides two xrd amounts and drops 19th decimal place and returns the integer part and remainder part" do
      assert {"1", "12.000000000000000001"} ==
               Util.xrd_div_rem("24.0000000000000000036", "12.0000000000000000024")
    end

    test "divides two xrd amounts and drops 19th decimal place and returns the integer part and remainder part and results in smallest amount" do
      assert {"0", "1.000000000000000002"} ==
               Util.xrd_div_rem(
                 "1.0000000000000000026",
                 "1000000000000000000.0000000000000000024"
               )
    end
  end

  describe "xrd_equal?/2" do
    test "check if an xrd amounts is equal to another - down to 18th decimal place" do
      assert true == Util.xrd_equal?("12.0000000000000000026", "12.0000000000000000024")
    end

    test "check if an xrd amounts is equal to another - down to 18th decimal place - should be false" do
      assert false == Util.xrd_equal?("12.0000000000000000036", "12.0000000000000000024")
    end
  end

  describe "xrd_gt?/2" do
    test "check if an xrd amounts is greater than another - down to 18th decimal place" do
      assert false == Util.xrd_gt?("12.0000000000000000026", "12.0000000000000000024")
    end

    test "check if an xrd amounts is greater than another - down to 18th decimal place - should be false" do
      assert true == Util.xrd_gt?("12.0000000000000000036", "12.0000000000000000024")
    end

    test "check if an xrd amounts is greater than another - down to 18th decimal place - should be true" do
      assert false == Util.xrd_gt?("12.0000000000000000016", "12.0000000000000000024")
    end
  end

  describe "xrd_lt?/2" do
    test "check if an xrd amounts is less than another - down to 18th decimal place" do
      assert false == Util.xrd_lt?("12.0000000000000000026", "12.0000000000000000024")
    end

    test "check if an xrd amounts is less than another - down to 18th decimal place - should be false" do
      assert false == Util.xrd_lt?("12.0000000000000000036", "12.0000000000000000024")
    end

    test "check if an xrd amounts is less than another - down to 18th decimal place - should be true" do
      assert true == Util.xrd_lt?("12.0000000000000000016", "12.0000000000000000024")
    end
  end

  describe "xrd_max/2" do
    test "gets the max between two xrd amounts - down to 18th decimal place - 1" do
      assert "12.000000000000000002" ==
               Util.xrd_max("12.0000000000000000026", "12.0000000000000000024")
    end

    test "gets the max between two xrd amounts - down to 18th decimal place - 2" do
      assert "12.000000000000000003" ==
               Util.xrd_max("12.0000000000000000036", "12.0000000000000000024")
    end

    test "gets the max between two xrd amounts - down to 18th decimal place - 3" do
      assert "12.000000000000000002" ==
               Util.xrd_max("12.0000000000000000016", "12.0000000000000000024")
    end
  end

  describe "xrd_min/2" do
    test "gets the min between two xrd amounts - down to 18th decimal place - 1" do
      assert "12.000000000000000002" ==
               Util.xrd_min("12.0000000000000000026", "12.0000000000000000024")
    end

    test "gets the min between two xrd amounts - down to 18th decimal place - 2" do
      assert "12.000000000000000002" ==
               Util.xrd_min("12.0000000000000000036", "12.0000000000000000024")
    end

    test "gets the min between two xrd amounts - down to 18th decimal place - 3" do
      assert "12.000000000000000001" ==
               Util.xrd_min("12.0000000000000000016", "12.0000000000000000024")
    end
  end

  describe "xrd_mult/2" do
    test "multiplies two xrd amounts - down to 18th decimal place - 1" do
      assert "6" ==
               Util.xrd_mult("12.0000000000000000016", "0.5")
    end

    test "multiplies two xrd amounts - down to 18th decimal place - 2" do
      assert "24.000000000000000002" ==
               Util.xrd_mult("12.0000000000000000016", "2")
    end
  end

  describe "xrd_negate/2" do
    test "negates an xrd amount - down to 18th decimal place - 1" do
      assert "-0.000000000000000001" ==
               Util.xrd_negate("0.000000000000000001")
    end

    test "negates an xrd amount - down to 18th decimal place - 2" do
      assert "-12.000000000000000001" ==
               Util.xrd_negate("12.0000000000000000016")
    end

    test "negates an xrd amount - down to 18th decimal place - 3" do
      assert "12.000000000000000001" ==
               Util.xrd_negate("-12.0000000000000000016")
    end
  end

  describe "xrd_negative?/2" do
    test "check if an xrd amount is negative - down to 18th decimal place - 1" do
      assert false ==
               Util.xrd_negative?("0.000000000000000001")
    end

    test "check if an xrd amount is negative - down to 18th decimal place - 2" do
      assert true ==
               Util.xrd_negative?("-0.000000000000000001")
    end

    test "check if an xrd amount is negative - down to 18th decimal place - 3" do
      assert true ==
               Util.xrd_negative?("-12.0000000000000000016")
    end
  end

  describe "xrd_positive?/2" do
    test "check if an xrd amount is positive - down to 18th decimal place - 1" do
      assert true ==
               Util.xrd_positive?("0.000000000000000001")
    end

    test "check if an xrd amount is positive - down to 18th decimal place - 2" do
      assert false ==
               Util.xrd_positive?("-0.000000000000000001")
    end

    test "check if an xrd amount is positive - down to 18th decimal place - 3" do
      assert false ==
               Util.xrd_positive?("-12.0000000000000000016")
    end
  end

  describe "xrd_rem/2" do
    test "gets the remainder of integer division of two XRD amounts - 1" do
      assert "1" ==
               Util.xrd_rem("5", "2")
    end

    test "gets the remainder of integer division of two XRD amounts - 2" do
      assert "0.000000000000000001" ==
               Util.xrd_rem("1.000000000000000002", "1.000000000000000001")
    end
  end

  describe "xrd_round/2" do
    test "rounds an XRD amount" do
      assert "6" ==
               Util.xrd_round("5.6")
    end
  end

  describe "xrd_sqrt/2" do
    test "gets the sqrt of an XRD amount" do
      assert "2.366431913239846417" ==
               Util.xrd_sqrt("5.6")
    end
  end

  describe "xrd_sub/2" do
    test "gets the difference of two XRD amounts - 1" do
      assert "3" ==
               Util.xrd_sub("5", "2")
    end

    test "gets the difference of two XRD amounts - 2" do
      assert "0.000000000000000001" ==
               Util.xrd_sub("1.000000000000000002", "1.000000000000000001")
    end

    test "gets the difference of two XRD amounts - 3" do
      assert "0" ==
               Util.xrd_sub("0.000000000000000001", "0.000000000000000001")
    end

    test "gets the difference of two XRD amounts - 4" do
      assert "-0.000000000000000001" ==
               Util.xrd_sub("0.000000000000000001", "0.000000000000000002")
    end
  end
end
