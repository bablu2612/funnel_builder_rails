# instialize
require "stripe"

Rails.configuration.stripe= {
    publishable_key:'pk_test_mZv2xlJby5Pt6DeGZcg2zNvA00VAboTJ38',#ENV['PUBLISHABLE_KEY'],
    secret_key:'sk_test_BMHo4P2D81el6tcJ88K8ureu005fondgSO'#ENV['SECRET_KEY']
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]