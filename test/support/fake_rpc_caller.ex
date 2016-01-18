defmodule FakeRpcCaller do
  defstruct []
end

defimpl RemoteCaller, for: FakeRpcCaller do
  def call(rpc, node, mod, fun, args) do
    [0, [:something], nil]
  end
end
