Rails.application.config.assets.precompile += %w( ckeditor/* )

types = %w(*.png *.gif *.jpg *.eot *.woff *.ttf *.svg)
Rails.application.config.assets.precompile += types