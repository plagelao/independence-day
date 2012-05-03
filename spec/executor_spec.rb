require './lib/executor'

FUNCTION = ->(text, *args) { "something" }
NAMER = ->(name) { "a_name" }
class SomethingThatExecutesSomething
  extend Independent::Executor
  generate_methods FUNCTION, NAMER, :test
end

describe Independent::Executor do

  let(:something) { SomethingThatExecutesSomething.new }
  let(:function) { FUNCTION }

  it 'creates a method to execute the function base on the namer' do
    something.respond_to?(:a_name).should be_true
  end

  it 'creates an attribute writer with the same name of the method' do
    something.respond_to?(:a_name=).should be_true
  end

  it 'the new method executes the function with the arguments' do
    function.should_receive(:call).with(:test, :anything, :something)
    something.a_name.(:anything, :something)
  end

  it 'if we override the attribute writer then the new method returns whatever we set' do
    something.a_name = "other thing"
    something.a_name.should == "other thing"
  end
end
