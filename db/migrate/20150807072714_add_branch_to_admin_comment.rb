class AddBranchToAdminComment < ActiveRecord::Migration
  def change
    add_column :admin_comments, :branch, :string #分支／分站， 可以根据判断分站，发送短信到不同的分站管理员
    add_column :admin_comments, :datetime, :datetime
  end
end
