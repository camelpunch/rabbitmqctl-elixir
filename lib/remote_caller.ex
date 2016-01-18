defprotocol RemoteCaller do
  def call(rpc, node, mod, fun, args)
end
