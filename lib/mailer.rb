require './lib/executor'

module Independent::Mailer
  include Independent::Executor

  def add_mail_sender_for(*args)
    mailer = ->(mail, *args) {
      UserMailer.send(mail, *args).deliver
    }
    namer = ->(name) { "send_#{name}_mail" }
    generate_methods(mailer, namer, *args)
  end
end
