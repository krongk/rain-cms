class Admin::Channel < ActiveRecord::Base
  belongs_to :user
end
