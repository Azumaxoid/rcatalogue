class SockGetter
  include Service

  def initialize(sock_id)
    @sock_id = sock_id
  end

  def call
    @socks = Sock.where(sock_id: @sock_id).where.not(name: nil).where("count > ?", 0)
    if @socks.length == 0
      return { message: "There are no item. Please select other items", error: true }, :status => :internal_server_error
    end
    @sock = @socks[0]
    @tags = SockTag.where(sock_id: @sock_id).map{|sockTag| Tag.find_by(tag_id: sockTag.tag_id).name}
    return {
      "id": @sock.sock_id,
      "name": @sock.name,
      "description": @sock.description,
      "price": @sock.price,
      "count": @sock.count,
      "imageUrl": [@sock.image_url_1, @sock.image_url_2],
      "tags": @tags,
      "error": false
    }
  end

end