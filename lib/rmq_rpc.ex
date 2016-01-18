defmodule RMQRpc do
  defstruct []
end

defimpl RemoteCaller, for: RMQRpc do
  def call(_, _, _, _, _) do
  end
end
