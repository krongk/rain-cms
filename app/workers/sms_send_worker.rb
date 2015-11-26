class SmsSendWorker
  include Sidekiq::Worker

  def perform(mobile_phone, content)
    status_id = SmsBao.send(ENV['SMS_BAO_USER'], ENV['SMS_BAO_PASSWORD'], mobile_phone, content)
    puts "laundry sms send to: #{mobile_phone} -> #{status_id}"
    puts content
    status_id
  end
end
