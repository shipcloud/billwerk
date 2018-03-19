[![Build Status](https://travis-ci.org/shipcloud/pactas_itero.svg)](https://travis-ci.org/shipcloud/pactas_itero)

# PactasItero

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pactas_itero'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pactas_itero

## Usage

### INIT:
```
PactasItero.client_id = "my_billwerk_client_id"
PactasItero.client_secret = "my_billwerk_client_secret"
@billwerkClient = PactasItero.client
@billwerkClient.bearer_token = @billwerkClient.try(:token).try(:access_token)
```

### Examples:

#### 1) Create-Plan Example

```
plangroup_id = "16dc8c7gba5c2202143de8b5"
plan_options={}
plan_options[:Name] = {"_c" => "Package XXL" }
plan_options[:PlanDescription] = {"_c"=>"This is the Plan-Description for XXL"}
plan_options[:PlanGroupId] = plangroup_id
plan_options[:SetupDescription] = {"_c"=>"one-time setup-fee"}
plan_options[:TrialEndNotificationPeriod] = {'Unit' => "Day", 'Quantity' => 3}
plan_options[:TrialEndPolicy] = "RequestPayment"
plan_options[:TrialPeriod] = {:Unit => "Day", :Quantity => 7}  
plan_options[:IsQuantityBased] = false
plan_options[:Hidden] = false
plan_options[:IsDeletable] = false
@plan=@billwerkClient.create_plan(plangroup_id,plan_options)
```

#### 2) Create-Order Example   

##### Submitted via Order-Form (Example Data)

```
Parameters: {"Cart"=>{"PlanVariantId"=>"19dc8c7gba5c2202143de1s9"}, 
	"Customer"=>{"CompanyName"=>"Mustermann Ltd.", "EmailAddress"=>"mustermann@test.de", "FirstName"=>"Klaus", "LastName"=>"Mustermann", "VatId"=>"DE63244715",
	"Address"=>{"Street"=>"Karl-Str.", "HouseNumber"=>"55", "PostalCode"=>"10421", "City"=>"Berlin", "Country"=>"DE"}}, 
	"Bearer"=>{"holder"=>"Mustermann Ltd", "iban"=>"DE883299699663", "bic"=>"HAC556AXXX"}}
```

##### Usage in Order-Controller 

```
orderOptions = {}
orderOptions[:ContractCustomFields] = {}
orderOptions[:AdditionalData] = {}
orderOptions[:AdditionalData][:Contract] = {}
orderOptions[:AdditionalData][:Contract][:CustomFields]  = {}
orderOptions[:Cart] = params[:Cart].to_h
orderOptions[:Cart][:Quantity] = 1
orderOptions[:Cart][:EnableTrial] = true
orderOptions[:Cart][:ComponentSubscriptions] = []
orderOptions[:Cart][:MeteredUsages] = []
orderOptions[:Cart][:DiscountSubscriptions] = []
orderOptions[:Cart][:RatedItems] = []
orderOptions[:Customer] = params[:Customer].to_h
orderOptions[:Customer][:ExternalCustomerId] = "#{current_customer.id}"
orderOptions[:Customer][:Language] = 'de-DE';
orderOptions[:Customer][:Locale] = 'de-DE';
orderOptions[:Customer][:DebitorAccount] = "#{current_customer.debit_id}"
orderOptions[:Customer][:Hidden] = false
orderOptions[:StartDate] = Time.now.to_formatted_s(:iso8601)    
@order=@billwerkClient.create_order(orderOptions)  
```

##### On Success Commit-Order via Order-Controller 

```
commitOptions = {}
commitOptions[:PaymentMethod] = "Debit:FakeProvider"
commitOptions[:Bearer] = params[:Bearer].to_h
commitOptions[:Bearer][:mandatereference] = "Z-#{current_customer.debit_id}-#{current_customer.id}"
@commit = @billwerkClient.commit_order(@order.id, commitOptions)
```    

## Contributing

1. Fork it ( https://github.com/[my-github-username]/pactas_itero/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
