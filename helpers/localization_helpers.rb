module LocalizationHelpers
  def local_path(url, options = {})
    lang = options.fetch(:lang, I18n.locale.to_s )
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
end
