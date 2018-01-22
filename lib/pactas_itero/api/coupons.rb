module PactasItero
  module Api
    module Coupons
      def coupons(options = {})
        options = options.camelize_keys
        get "api/v1/coupons", options
      end

      def coupon(coupon_id, options = {})
        options = options.camelize_keys
        get "api/v1/coupons/#{coupon_id}", options
      end

      def coupon(coupon_id, options = {})
        options = options.camelize_keys
        get "api/v1/coupons/#{coupon_id}", options
      end

      def coupon_by_code(coupon_code, options = {})
        options = options.camelize_keys
        get "api/v1/coupons/?couponCode=#{coupon_code}", options
      end

    end
  end
end