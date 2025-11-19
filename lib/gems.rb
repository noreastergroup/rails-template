def gemfile_strip
  gsub_file 'Gemfile', /^\s*\n/, ''
end

def gemfile_respace
  gsub_file 'Gemfile', /([^\n])\n([^\n]*do)$/, "\\1\n\n\\2"
  gsub_file 'Gemfile', /^(source "https:\/\/rubygems.org")\n/, "\\1\n\n"
end

def install_gem(string)
  insert_into_file 'Gemfile', string, before: "group :development, :test do\n"
end

def install_dev_gem(string)
  insert_into_file 'Gemfile', string.indent(2), after: "group :development do\n"
end
