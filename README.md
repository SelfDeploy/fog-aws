# For SD team: how to contribute

## I want to suggest the diff to fog team:

1. **make sure you've got the remotes**
  ```
  git remote -v
  ```
  You should have 2 remotes, one for `git@github.com:SelfDeploy/fog-aws.git` and an other for `git@github.com:fog/fog-aws.git`
  If not, add it:
  ```
  git remote add [REMOTE NAME YOU WANT] [REMOTE ADDRESS]
  ```
  We strongly recommand:
* REMOTE NAME YOU WANT: origin, REMOTE ADDRESS: `git@github.com:SelfDeploy/fog-aws.git`
* REMOTE NAME YOU WANT: upstream, REMOTE ADDRESS: `git@github.com:fog/fog-aws.git`

2. **make sure your remotes are up to date**
  ```
  git fetch -p --all
  ```

3. **make sure your branch is based on upstream's master**
  ```
	git rebase upstream/master
  ```

4. **push your branch and create PR on base fog/fog-aws:master**

## I want to create a new release for SD until my diff is merged on fog

1. **Ensure that branch `selfDeploy` is up to date with the tag used by SD's API's gemfile**

2. **create your diff branch based on sd**
  ```
  gco -b [branch name]
	# for each commit on your diff
	git cherry-pick [commit's sha]
  ```
  Then push the branch

3. **Open pr from this new branch to base SelfDeploy/fog-aws:selfdeploy**

4. **tag la release sd**
	go to gh, tag selfdeploy's branch latest to new release called sd-v[X.Y.Z]


# Fog::Aws

![Gem Version](https://badge.fury.io/rb/fog-aws.svg)
[![Build Status](https://travis-ci.org/fog/fog-aws.svg?branch=master)](https://travis-ci.org/fog/fog-aws)
[![Dependency Status](https://gemnasium.com/fog/fog-aws.svg)](https://gemnasium.com/fog/fog-aws)
[![Test Coverage](https://codeclimate.com/github/fog/fog-aws/badges/coverage.svg)](https://codeclimate.com/github/fog/fog-aws)
[![Code Climate](https://codeclimate.com/github/fog/fog-aws.svg)](https://codeclimate.com/github/fog/fog-aws)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fog-aws'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fog-aws

## Usage

Before you can use fog-aws, you must require it in your application:

```ruby
require 'fog/aws'
```

Since it's a bad practice to have your credentials in source code, you should load them from default fog configuration file: ```~/.fog```. This file could look like this:

```
default:
  aws_access_key_id:     <YOUR_ACCESS_KEY_ID>
  aws_secret_access_key: <YOUR_SECRET_ACCESS_KEY>
```

### Connecting to EC2 service
```ruby
ec2 = Fog::Compute.new :provider => 'AWS', :region => 'us-west-2'
```

You can review all the requests available with this service using ```#requests``` method:

```ruby
ec2.requests # => [:allocate_address, :assign_private_ip_addresses, :associate_address, ...]
```

### Launch an EC2 on-demand instance:

```ruby
response = ec2.run_instances(
  "ami-23ebb513",
  1,
  1,
  "InstanceType"  => "t1.micro",
  "SecurityGroup" => "ssh",
  "KeyName"       => "miguel"
)
instance_id = response.body["instancesSet"].first["instanceId"] # => "i-02db5af4"
instance = ec2.servers.get(instance_id)
instance.wait_for { ready? }
puts instance.public_ip_address # => "356.300.501.20"
```

### Terminate an EC2 instance:

```ruby
instance = ec2.servers.get("i-02db5af4")
instance.destroy
```

Fog::AWS is more than EC2 since it supports many services provided by AWS. The best way to learn and to know about how many services are supported is to take a look at the source code. To review the tests directory and to play with the library in ```irb``` can be very helpful resources as well.

## Documentation

See the [online documentation](http://www.rubydoc.info/github/fog/fog-aws) for a complete API reference.

## Contributing

1. Fork it ( https://github.com/fog/fog-aws/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
