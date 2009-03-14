$LOAD_PATH.unshift File.dirname(__FILE__)

libs = %w{ sqlite3 yaml }

begin
  libs.each { |lib| require lib }
rescue LoadError
  require 'rubygems'
  libs.each { |lib| require lib }
end

require 'core_ext/hashish'

module AppConfig
  VERSION = '0.1.0'

  autoload :Base, 'app_config/base'
  autoload :Storage, 'app_config/storage'

  def self.to_version
    "#{self.class} v#{VERSION}"
  end

  # Access the configured <tt>key</tt>'s value.
  def self.[](key)
    error = "Must call '#{self}.configure' to setup storage!"
    raise error if @@storage.nil?
    @@storage[key]
  end

  # Accepts an +options+ hash or pass a block.
  # See AppConfig::Base for valid options.
  def self.configure(options = {}, &block)
    @@storage = AppConfig::Base.new(options, &block)
  end

end