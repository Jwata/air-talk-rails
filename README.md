# Cheap Rails hosting samples
You will see 2 different cheap rails hosting samples in this repository.

* [Prepare Rails app](#prepare-rails-app)
* [PaaS pattern](#paas-pattern)
* [IaaS pattern](#iaas-pattern)

## Prepare Rails app
You need to setup a secret key for production
In this demo, you will use [Encrypted secrets](https://github.com/rails/rails/blob/db844d9fb30cd34411fcdcc6780f82aaa5471e81/guides/source/5_1_release_notes.md#encrypted-secrets) to manage the secret key.  
You will also need to set a environment variable `RAILS_MASTER_KEY` on each platform.

```
> rails secrets:setup
> cat config/secrets.yml.key
=> your_rails_master_key
```
```
> rails secrets:edit
# production:
#   secret_key_base: your_secret_key
```

## PaaS pattern
> PaaS functions at a lower level than SaaS, typically providing a platform on which software can be developed and deployed. PaaS providers abstract much of the work of dealing with servers and give clients an environment in which the operating system and server software, as well as the underlying server hardware and network infrastructure are taken care of, leaving users free to focus on the business side of scalability, and the application development of their product or service.

> As with most cloud services, PaaS is built on top of virtualization technology. Businesses can requisition resources as they need them, scaling as demand grows, rather than investing in hardware with redundant resources.

> from: [WHAT’S THE DIFFERENCE BETWEEN SAAS, PAAS, IAAS?](https://www.computenext.com/blog/when-to-use-saas-paas-and-iaas/)


[Heroku](https://www.heroku.com/) is one of the platforms where you can deploy your rails app easily. and they have free plans for application containers, DB (postgres), Cache (Redis).
So you can host your Rails application for completely free.

### Demo
[https://air-talk-rails.herokuapp.com/](https://air-talk-rails.herokuapp.com/)

### Infrastructures and Tools
* Framework: [Rails 5](https://github.com/rails/rails)
* Hosting: [Heroku](https://www.heroku.com/)
* Deployment: [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)
* Storage: [Heroku Postgres](https://devcenter.heroku.com/articles/heroku-postgresql)

### Prerequisites
* Heroku account
* Heroku CLI

### Sample code
Check out [heroku branch](https://github.com/Jwata/air-talk-rails/tree/heroku)

### Create app
```
> heroku login
> heroku key:add
> heroku create air-talk-rails
> heroku config:set RAILS_MASTER_KEY=`cat config/secrets.yml.key`
```

### Deploy
```
> heroku run rake db:migrate
> git push heroku master
```

## IaaS pattern
>  IaaS is comprised of highly automated and scalable compute resources, complemented by cloud storage and network capability which can be self-provisioned, metered, and available on-demand.

> IaaS providers offer these cloud servers and their associated resources via dashboard and/or API. IaaS clients have direct access to their servers and storage, just as they would with traditional servers but gain access to a much higher order of scalability. Users of IaaS can outsource and build a “virtual data center” in the cloud and have access to many of the same technologies and resource capabilities of a traditional data center without having to invest in capacity planning or the physical maintenance and management of it.
> 
> IaaS is the most flexible cloud computing model and allows for automated deployment of servers, processing power, storage, and networking. IaaS clients have true control over their infrastructure than users of PaaS or SaaS services. The main uses of IaaS include the actual development and deployment of PaaS, SaaS, and web-scale applications.

> from: [WHAT’S THE DIFFERENCE BETWEEN SAAS, PAAS, IAAS?](https://www.computenext.com/blog/when-to-use-saas-paas-and-iaas/)

[AWS](https://aws.amazon.com/) is one of the most popular IaaS providers.
Because of their flexibility, they are complicated to setup infrastructures. but [AWS Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/) helps you host web application easily like PaaS.  
If you host your own relational database on AWS, it's pretty expensive. but they have [free DynamoDB tier](https://aws.amazon.com/jp/dynamodb/pricing/).

### Demo
[http://production.qxt33phftr.us-west-2.elasticbeanstalk.com/](http://production.qxt33phftr.us-west-2.elasticbeanstalk.com/)

### Infrastructures and Tools
* Framework: [Rails 5](https://github.com/rails/rails)
* Hosting: [AWS Elastic Beanstalk (Single Instance)](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/using-features-managing-env-types.html)
* Deployment: [AWS EB CLI](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html)
* Storage: [AWS DynamoDB](https://aws.amazon.com/dynamodb/)

### Prerequisites
* AWS account
* AWS CLI
* AWS EB CLI

### Code sample
Check out [aws-beanstalk-with-dynamodb branch](https://github.com/Jwata/air-talk-rails/tree/aws-beanstalk-with-dynamodb)

### Create app

```
> eb init
> eb create production --cfg .elasticbeanstalk/saved_configs/production-sc.cfg.yml
> eb use production
> eb setenv RAILS_MASTER_KEY=`cat config/secrets.yml.key`
```

### Deploy
```
eb deploy produciton
```

### DB Migration

Rails DB migration depends on a relational database (SQLite, Postgres, MySQL) to manager schema versions. and I couldn't find a way to use the migration without database. so you have to create tables on dynamo in a EC2 instance manually.

```
eb ssh production
cd /var/app/current
rake dynamo:create_tables
```
