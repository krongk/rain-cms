#encoding: utf-8
class Admin::Comment < ActiveRecord::Base
  #empty
  validates :mobile_phone, presence: true
  #length
  validates :mobile_phone, length: { is: 11 }
  #format
  validates :mobile_phone, format: { with: /\A1(3|5|8|9)[0-9]{9}\z/, message: "请输入正确的手机号码" }

  STATUS = %w[未处理 已处理 垃圾信息]

  after_create :send_sms

  def send_sms
   if ENV['SMS_TOGGLE']
      SmsSendWorker.perform_async(ENV['SMS_PHONE'].split('|').join(','), "【#{Admin::Keystore.value_for('site_name') || '直达客'}】您有新的留言，#{name} #{mobile_phone} #{content.nil? ? '希望你尽快与他取得联系' : content.to_s.truncate(36)}")
      SmsSendWorker.perform_async(mobile_phone, "【#{Admin::Keystore.value_for('site_name') || '直达客'}】感谢您的留言，我们会尽快与您取得联系！")
    end
  end
end
