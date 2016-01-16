require 'digest/md5'
require 'open-uri'

module SmsBao
  # $statusStr = array(
  #   "0" => "短信发送成功",
  #   "-1" => "参数不全",
  #   "-2" => "服务器空间不支持,请确认支持curl或者fsocket，联系您的空间商解决或者更换空间！",
  #   "30" => "密码错误",
  #   "40" => "账号不存在",
  #   "41" => "余额不足",
  #   "42" => "帐户已过期",
  #   "43" => "IP地址限制",
  #   "50" => "内容含有敏感词"
  # );
  def self.send(user_name, password, phones, content)
    result = nil
    password = Digest::MD5.hexdigest password
    begin
      #surl = "http://www.smsbao.com/sms?u=#{user_name}&p=#{password}&m=#{phones}&c=#{URI.escape(content)}"
      surl = "http://api.smsbao.com/sms?u=#{user_name}&p=#{password}&m=#{phones}&c=#{URI.escape(content)}"
      open(surl) {|f|
        f.each_line {|line| result = line}
      }
    rescue => ex
      return ex.message
    end
    result
  end
  
  def self.query(user_name, password)
    result = nil
    password = Digest::MD5.hexdigest password
    begin
      open("http://www.smsbao.com/query?u=#{user_name}&p=#{password}") {|f|
        f.each_line {|line| result = line}
      }
    rescue => ex
      return ex.message
    end
    result
  end
end