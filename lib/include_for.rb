# IncludeFor
module IncludeFor
  def include_for(*sources)
    sources = sources.flatten
    options = sources.last.is_a?(Hash) ? sources.pop.symbolize_keys : {}
    group   = options.delete(:to) || :header
    global_cache  = eval("@_include_for_#{options[:to]}_ ||= {}")
    private_cache = {}

    loadeds = sources.map do |source|
      include_for_cache_or_find(group, source, options, global_cache, private_cache)
    end
    loadeds.compact
  end

  private
    def include_for_source(source, options)
      case source
      when :defaults, /\.js$/ then javascript_include_tag(source, options)
      when /\.css$/           then stylesheet_link_tag(source, options)
      else source.to_s
      end
    end

    def include_for_cache_or_find(group, source, options, global_cache, private_cache)
      if private_cache[source]
        nil
      else
        private_cache[source] ||= global_cache[source] ||=
          returning(erb = include_for_source(source, options)) {content_for(group){erb}}
      end
    end
end
