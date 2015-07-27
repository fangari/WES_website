###
# Helpers
###

helpers

# Activate localization for multiple language support
activate :i18n, mount_at_root: false, langs: [:en, :es]

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
set :url_root, 'https://worldemeraldsymposium.com'
activate :search_engine_sitemap
configure :build do
  activate :autoprefixer do |config|
    config.browsers = ['last 2 versions', '> 5%', 'Explorer >= 9']
  end
  activate :minify_css
  activate :minify_javascript
  activate :gzip
  activate :imageoptim do |options|
    options.manifest = true
    options.nice = true
    options.threads = true
    options.image_extensions = %w(.png .jpg)
  end
  activate :minify_html, remove_input_attributes: false
  activate :asset_hash
  activate :relative_assets
end

case ENV['TARGET'].to_s.downcase
when 'production'
  activate :deploy do |deploy|
    deploy.method       = :ftp
    deploy.host         = 'ftp.worldemeraldsymposium.com'
    deploy.port         = 21
    deploy.path         = 'public_html'
    deploy.user         = 'worlqezp'
    deploy.password     = 'Qm-PUK1roOADR'
  end
else
  activate :deploy do |deploy|
    deploy.method       = :ftp
    deploy.host         = 'ftp.worldemeraldsymposium.com'
    deploy.port         = 21
    deploy.path         = 'public_html/staging'
    deploy.user         = 'worlqezp'
    deploy.password     = 'Qm-PUK1roOADR'
  end
end
