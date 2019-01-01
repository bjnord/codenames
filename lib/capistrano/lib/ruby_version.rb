def gemfile_ruby_version
  ruby_ver = '2.5.3'  # fallback default
  File.foreach('Gemfile') do |line|
    if m = line.match(/^ruby\s+'([\d.]*)'/)
      ruby_ver = m[1]
      break
    end
  end
  ruby_ver
end
