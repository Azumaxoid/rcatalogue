class TagSelector
  include Service
  def call
    sql = <<-"EOS"
SELECT tags.name as name, count(DISTINCT socks.sock_id) as count FROM socks
  INNER JOIN sock_tags ON socks.sock_id = sock_tags.sock_id
  INNER JOIN tags ON sock_tags.tag_id = tags.tag_id
GROUP BY tags.name
    EOS
    result = ActiveRecord::Base.connection.select_all(sql).to_a
    return result
  end

end