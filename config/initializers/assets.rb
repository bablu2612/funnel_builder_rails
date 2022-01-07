# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( admin/bootstrap.min.css )
Rails.application.config.assets.precompile += %w( admin/bootstrap-theme.css )
Rails.application.config.assets.precompile += %w( admin/style.css )
Rails.application.config.assets.precompile += %w( admin/dashboard.css )
Rails.application.config.assets.precompile += %w( admin/bootstrap.min.js )
Rails.application.config.assets.precompile += %w( admin/custom.js )
Rails.application.config.assets.precompile += %w( rails.validations.js )
Rails.application.config.assets.precompile += %w( admin/customvalidation.js )
Rails.application.config.assets.precompile += %w( admin/jquery.min.js )
Rails.application.config.assets.precompile += %w( admin/dataTabels.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.css )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( customvalidations.js )
Rails.application.config.assets.precompile += %w( admin/report.scss )
Rails.application.config.assets.precompile += %w( admin/cable.js )