class CheckoutRetrieve
    attr_reader :session_id, :expand
    def initialize(session_id, expand)
        byebug
        @session_id = session_id
        @expand = expand
    end

    def call 
        retrieve_checkout
    end

    def retrieve_checkout
        byebug
        # return (Stripe::Checkout::Session.retrieve({ session_id, expand: expand}))
        session_with_expand = (Stripe::Checkout::Session.retrieve({ id: session_id, expand: expand}))
        email_id = session_with_expand.customer_details.email
        user = User.find_by(email: email_id)
        @course_name = session_with_expand.line_items.data[0].description
        @course = Course.find_by(course_name: @course_name)
        if @payment.course == @course and @payment.user == user
            @payment.complete!
            @purchase = @course.purchases.new
            @purchase.user_id = user.id
            @purchase.save
            GenerateMailJob.perform_later(@purchase)
        else
            #Refund process
        end

        return session_with_expand
    end
end