class PostReminderJob < ApplicationJob
  queue_as :default


  def perform(product_id)
    product = Post.find product_id

    # send email reminder to owner of product
    if false
      PostReminderJob.set(wait: 1.minute).perform_later(product_id)
    end
  end
end
