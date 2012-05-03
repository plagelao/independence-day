require './lib/mailer'

unless defined?(UserMailer)
  class UserMailer; end
end

class SomethingThatSendsMails
  extend Independent::Mailer
  add_mail_sender_for :test
end
describe Independent::Mailer do
  let(:something) { SomethingThatSendsMails.new }

  it 'creates a method to send an email' do
    something.respond_to?(:send_test_mail).should be_true
  end

  it 'sends the right email when using the new method' do
    deliverer = stub(:deliverer)
    UserMailer.should_receive(:test).with(:anything, :something).
               and_return(deliverer)
    deliverer.should_receive(:deliver)
    something.send_test_mail.(:anything, :something)
  end
end
