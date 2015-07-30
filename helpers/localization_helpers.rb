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
    if url_matches?(current_resource, url)
      options.merge!(class: 'active') { |_key, oldval, newval| "#{oldval} #{newval}" }
    end
    localized_link_to(link, url, options)
  end

  def translated_url(locale)
    # Assuming /:locale/page.html
    return "/#{locale}/" if @page_id.nil?
    page_name = @page_id.split('/', 2).last.sub(/\..*$/, '')
    return  "/#{locale}/" if page_name.eql?('index')
    untranslated_path = t(:paths).key(page_name)
    begin
      translated = I18n.translate!("paths.#{untranslated_path}", locale: locale)
    rescue I18n::MissingTranslationData
      translated = untranslated_path
    end

    "/#{locale}/#{translated}"
  end

  def other_langs
    langs - [I18n.locale]
  end

  private

  def url_matches?(current_resource, url)
    url_with_trailing_slash_matches?(current_resource, url) ||
      url_without_trailing_slash_matches?(current_resource, url) ||
      url_is_root?(current_resource, url)
  end

  def  url_is_root?(current_resource, url)
    (current_resource.url + 'en/').eql?(url_for(local_path(url)))
  end

  def url_with_trailing_slash_matches?(current_resource, url)
    current_resource.url.eql?(url_for(local_path(url)) + '/')
  end

  def url_without_trailing_slash_matches?(current_resource, url)
    current_resource.url.eql?(url_for(local_path(url)))
  end
end
