module WeixinAuthorize
  def self.client
    #@@client ||= WeixinAuthorize::Client.new(ENV['WECHAT_APP_ID'], ENV['WECHAT_APP_SECRET'])
  end
end
