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
      @constrains[name] = { type: type, opt: opt }
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
      self.class.constrains.each do |name, params|
        method = params[:type].to_s
        send(method, name, params[:opt])
      end
    end

    def presence(name, _opt)
      attr = instance_variable_get("@#{name}")
      raise ArgumentError, 'You must input smth.' if attr.strip.size.zero?
    end
  end
end
