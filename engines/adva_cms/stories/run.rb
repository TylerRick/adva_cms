def files_to_load(paths)
  paths = ['.'] if paths.empty?
  result = []
  paths.each do |path|
    if File.directory?(path)
      # puts 'pattern: ' + dir_pattern(path)
      result += Dir[File.expand_path(dir_pattern(path))]
    elsif File.file?(path)
      result << path
    else
      raise "File or directory not found: #{path}"
    end
  end
  result.reject!{|path| path =~ /plugins|rspec/ }
  result
end

def dir_pattern(path)
  path = path.dup
  path.gsub!(/\/stories\/?$/, '')
  File.join(path, '**', 'stories', '**', '*.txt')
end

require File.dirname(__FILE__) + "/helper"

paths = ARGV.clone
paths.shift
paths = files_to_load(ARGV)

unless paths.empty?
  root_path = File.expand_path(File.dirname(__FILE__)).gsub(/vendor.*/, '')
  puts 'Running stories:'
  paths.each{|path| puts path.gsub(root_path, '') }

  paths.each do |path|
    with_steps_for *steps(:all) do
      run path, :type => RailsStory
    end
  end
end