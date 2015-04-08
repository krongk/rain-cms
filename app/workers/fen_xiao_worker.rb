class FenXiaoWorker
  include Sidekiq::Worker

  def perform(last_headquarter_id)
    FenXiao.new.run(last_headquarter_id)
  end
end
