###
# Helpers
###

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes
activate :directory_indexes

set :relative_links, true
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :fonts_dir, 'assets/fonts'

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Build-specific configuration
activate :inliner
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :gzip
  activate :image_optim
  activate :minify_html
  activate :asset_hash
  activate :relative_assets
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :ftp
end
