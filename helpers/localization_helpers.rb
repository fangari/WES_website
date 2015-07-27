module LocalizationHelpers
  def local_path(url, options = {})
    lang = options.fetch(:lang, I18n.locale.to_s)
    local_url = I18n.t("paths.#{url}")
    "/#{lang}/#{local_url}"
  end

  def localized_link_to(*args, &block)
    if block_given?
      link_to(local_path(args.shift), args.shift, &block)
    else
      link_to(I18n.t(args.shift), local_path(args.shift, {}), args.shift)
    end
  end

  def nav_link_to(link, url, options = {})
    if current_resource.url == (url_for(local_path(url)) + '/')
      options.merge!(class: 'active') do |_key, oldval, newval| 
        oldval +" "+ newval
      end
    end
    localized_link_to(link, url, options)
  end
end
