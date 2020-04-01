def generate_bc(url, separator)
  components = parse_tokens(url)
  breadcrumb(components, separator)
end

def breadcrumb(components, separator)
  last = components.pop
  breadcrumb = components.reduce('') do |breadcrumb, c|
    breadcrumb += "<a href=\"#{c[:url]}\">#{c[:text]}</a>" + separator
  end
  breadcrumb + "<span class=\"active\">#{last[:text]}</span>"
end

def parse_tokens(url)
  tokens = URI(url).path.split('/')
  tokens.shift
  if tokens.any?
    last = tokens.pop.split('.').first
    if last == 'index'
      last = tokens.pop
    end
    tokens.push(last) if last
  end
  to_components(tokens)
end

def to_components(tokens)
  components = [
    { :url => '/', :text => 'HOME' }
  ]
  tokens.reduce(components) do |components, token|
    components.push({
      :url => components.last[:url] + "#{token}/",
      :text => text(token)
    })
  end
end

def text(token)
  return acronym(token) if token.length > 30
  token.gsub('-', ' ').upcase
end

def acronym(token)
  ignore = %w"the of in from by with and or for to at a"
  token
    .split('-')
    .reject { |word| ignore.include?(word) }
    .map { |word| word[0].capitalize }
    .join
end
