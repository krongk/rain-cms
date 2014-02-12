############validate############################
  validates :key, format: { with: /\A[a-zA-Z0-9-]+\z/,
    message: "Key只能包括字母数字和横线" }
  validates :subdomain, exclusion: { in: %w(www us ca jp),
    message: "Subdomain %{value} is reserved." }
  validates :size, inclusion: { in: %w(small medium large),
    message: "%{value} is not a valid size" }
  #length
  validates :name, length: { minimum: 2 }
  validates :bio, length: { maximum: 500 }
  validates :password, length: { in: 6..20 }
  validates :registration_number, length: { is: 6 }
  validates :bio, length: { maximum: 1000,
    too_long: "%{count} characters is the maximum allowed" }
  validates :content, length: {
    minimum: 300,
    maximum: 400,
    tokenizer: lambda { |str| str.scan(/\w+/) },
    too_short: "must have at least %{count} words",
    too_long: "must have at most %{count} words"
  }
  #numerical int or float
  validates :points, numericality: true
  validates :games_played, numericality: { only_integer: true }
  #empty
  validates :name, :login, :email, presence: true
  #absence 缺席
  validates :name, :login, :email, absence: true
  #uniqueness
  validates :email, uniqueness: true
  validates :name, uniqueness: { case_sensitive: false } #default is true
  validates :name, uniqueness: { scope: :year, message: "should happen once per year" }
  #common options
  allow_nil: true
  :allow_blank
  :message
  on: :create
  if: :paid_with_card?
############validate############################
############HOW TO USE TAG############################
 
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
############HOW TO USE TAG############################
 

############Fix ckeditor picture ############################
change
:url  => "/ckeditor_assets/pictures/:id/:style_:basename.:extension" => 
:url  => "/ckeditor_assets/pictures/:id/:style.:extension",

def test
  tempfiles = File.join(Rails.root, "public", "ckeditor_assets", "**", "*.{jpg, png, gif, jpeg}")
  Dir.glob([tempfiles]).each do |img|
    new_img_path = img.sub(/(content|original|thumb)_.*[.](jpg|png|jpeg|gif).*$/, '\1.\2')
    next if new_img_path == img
    puts img
    puts new_img_path

    FileUtils.mv img, new_img_path
  end
  ''
end
############Add Cancan ############################
