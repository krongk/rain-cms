class Admin::Page < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  acts_as_taggable
  scope :by_join_date, order("created_at DESC")
end

=begin
 HOW TO USE TAG
  @user = User.new(:name => "Bobby")
  @user.tag_list = "awesome, slick, hefty"      # this should be familiar

  @user.tags

  @user.tag_list.remove("awesome")              # remove a single tag
  @user.tag_list.remove("awesome, slick")       # works with arrays too
  @user.tag_list.add("awesomer")                # add a single tag. alias for <<
  @user.tag_list.add("awesomer, slicker")       # also works with arrays

  User.tag_counts                             # => [<Tag name="joking" count=2>,<Tag name="clowning"
  
  User.tagged_with("awesome").by_join_date
  User.tagged_with("awesome").by_join_date.paginate(:page => params[:page], :per_page => 20)

  # Find a user with matching all tags, not just one
  User.tagged_with(["awesome", "cool"], :match_all => true)

  # Find a user with any of the tags:
  User.tagged_with(["awesome", "cool"], :any => true)

  # Find a user that not tags with awesome or cool:
  User.tagged_with(["awesome", "cool"], :exclude => true)
=end
