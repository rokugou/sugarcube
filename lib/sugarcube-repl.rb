unless defined?(Motion::Project::Config)
  raise "The sugarcube gem must be required within a RubyMotion project Rakefile."
end


require 'sugarcube'

Motion::Project::App.setup do |app|
  # This package is only available in development
  app.development do
    # scans app.files until it finds app/ (the default)
    # if found, it inserts just before those files, otherwise it will insert to
    # the end of the list
    insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

    Dir.glob(File.join(File.dirname(__FILE__), SugarCube.platform, 'sugarcube-repl/**/*.rb')).reverse.each do |file|
      app.files.insert(insert_point, file)
    end
    Dir.glob(File.join(File.dirname(__FILE__), 'cocoa/sugarcube-repl/**/*.rb')).reverse.each do |file|
      app.files.insert(insert_point, file)
    end
    Dir.glob(File.join(File.dirname(__FILE__), 'all/sugarcube-repl/**/*.rb')).reverse.each do |file|
      app.files.insert(insert_point, file)
    end
  end
end
