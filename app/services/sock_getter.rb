class SockGetter
  include Service

  def initialize(sock_id)
    @sock_id = sock_id
  end

  def call
    @sock = Sock.find(@sock_id)
    @tags = SockTag.where(sock_id: @sock_id).map{|sockTag| Tag.find(sockTag.tag_id).name}
    return {
      "id": @sock.sock_id,
      "name": @sock.name,
      "description": @sock.description,
      "price": @sock.price,
      "count": @sock.count,
      "imageUrl": [@sock.image_url_1, @sock.image_url_2],
      "tags": @tags
    }
  end

end