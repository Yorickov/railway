module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :constrains

    def validate(*args)
      @constrains ||= {}
      name, type, *opt = args
      @constrains[name] ||= []
      @constrains[name] << { type: type, opt: opt }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end

    protected

    def validate!
      self.class.constrains.each do |name, items|
        items.each do |c|
          attr = instance_variable_get("@#{name}")
          method = c[:type].to_s
          send(method, attr, c[:opt])
        end
      end
    end

    def presence(attr, _opt)
      raise ArgumentError, 'You must input smth.' if attr.strip.size.zero?
    end

    def format(attr, opt)
      raise ArgumentError, 'Invalid format' if attr.strip !~ opt[0]
    end

    def type(attr, opt)
      raise TypeError, 'wrong type' unless attr.is_a?(opt[0])
    end
  end
end
