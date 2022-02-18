# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [0.6.1](https://github.com/shipcloud/billwerk/compare/v0.6.0...v0.6.1) (2022-02-18)

### Added

* **contract-changes:** add contract changes endpoint ([#107](https://github.com/shipcloud/billwerk/issues/107)) ([9d440a6](https://github.com/shipcloud/billwerk/commit/9d440a6e1050bb12168bc3d19f566a3abebdbbbc))

### Changed

* Set required ruby version to >= 2.6
* Replace Travis CI with CircleCI
* `rubocop` version is specified to be `~> 1.8.1`
* `performance` version is specified to be `~> 1.7.0`


### [0.6.0] - 2021-03-03

### Changed
* `faraday_middleware` version is specified to be `>= 1.0.0`


### [0.5.0] - 2019-06-11

### Changed
* Updates gem dependencies to latest versions (#65):
  * replaces rash with rash_alt
  * removes specific faraday_middleware version dependency

### [0.4.0] - 2019-04-30

### Added
 * download Invoices as PDF (#60)

### Changed
* new prodcution endpoint (#45)


### [0.3.0] - 2017-09-04
### Added
* get a self service token for a given contract
* get a specific customer by id
* get and delete rated items
* get a specific payment transaction by id
* call to terminate a contract

### Changed
* update version of jruby to 9.1.5.0

### Removed
* support for ruby version 1.8.x and 1.9.x
* support for rubinius

### Fixed
* issue where stubbing the PactasItero.client method caused
  a "Stack level too deep" error on rspec > 3.3


### [0.2.0] - 2016-02-04
### Added
* a changelog
* get operation for orders
* create_customer method

### Changed
* create orders without a contract_id
* changes sandbox url from sandbox.pactas.com to sandbox.billwerk.com
