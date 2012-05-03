require './lib/executor'

module Independent::Maker
  include Independent::Executor

  def add_creator_of(*args)
    maker = ->(maker_name, *args) {
      the_class = class_for(maker_name)
      if the_class.respond_to?(:create!)
        the_class.create!(*args)
      else
        the_class.new(*args)
      end
    }
    namer = ->(name) { "create_#{name}" }
    generate_methods(maker, namer, *args)
  end

  def class_for(value)
    Kernel::const_get(camelcase(value.to_s))
  end

  def camelcase(a_string)
    a_string.split('_').map(&:capitalize).join
  end
end
