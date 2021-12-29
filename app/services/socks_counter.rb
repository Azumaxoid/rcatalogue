class SocksCounter
  include Service

  def initialize(tags)
    @tags = tags
  end

  def call
    @socks = [];
    if @tags.length > 0
      @socks = Sock.all.filter {
        |sock| @tags.find { |tag| tag == Tag.find(SockTag.find_by(sock_id: sock.sock_id).tag_id).name }
      }
    else
      @socks = Sock.all
    end
    return { size: @socks.size }
  end

end