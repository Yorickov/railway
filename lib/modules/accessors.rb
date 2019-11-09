module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        @all_attrs ||= {}
        @all_attrs[name] ||= []
        @all_attrs[name] << value

        instance_variable_set(var_name, value)
      end

      define_method("#{name}_history") { @all_attrs[name] }
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise TypeError, 'Wrong type' unless value.is_a?(type)

      instance_variable_set(var_name, value)
    end
  end
end
