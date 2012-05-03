module Independent
  module Executor
    def generate_methods(function, namer, *args)
      args.each do |text|
        name = namer.(text)
        attr_writer name
        define_method name do |*args|
          executor = ->(*args) {
            function.(text, *args)
          }
          instance_variable_set(:"@#{name}", executor) unless instance_variable_get(:"@#{name}")
          instance_variable_get(:"@#{name}")
        end
      end
    end
  end
end
