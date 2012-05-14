module Independent
  module Executor
    def generate_methods(function, namer, *args)
      args.each do |text|
        executor = ->(*args) {
          function.(text, *args)
        }
        generate_method(function, namer.(text), executor)
      end
    end

    def generate_method(function, attribute_name, executor)
      attr_writer attribute_name

      define_method attribute_name do |*args|
        attribute_symbol = :"@#{attribute_name}"
        attribute_value = instance_variable_get(attribute_symbol)
        attribute_value || executor
      end
    end
  end
end
