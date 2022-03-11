ExUnit.start()
Mox.defmock(Radixir.MockHTTP, for: Radixir.HTTP)
Application.put_env(:radixir, :http, Radixir.MockHTTP)
