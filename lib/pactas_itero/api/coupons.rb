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
      
      def create_coupon(plangroup_id, options = {})
        options = options.camelize_keys
        post "api/v1/planGroups/#{plangroup_id}/coupons", options
      end

      def update_coupon(coupon_id, options = {})
        options = options.camelize_keys
        patch "api/v1/coupons/#{coupon_id}", options
      end
      
      def coupon_by_code(coupon_code, options = {})
        options = options.camelize_keys
        get "api/v1/coupons/?couponCode=#{coupon_code}", options
      end

    end
  end
end