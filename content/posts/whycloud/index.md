--- 

title: "What are the reasons for cloud adoption?" 

date: 2021-11-22T12:22:08+01:00 

draft: false 

comments: true 

toc: false

images:

tags:
  - Cloud
  - Azure
  - Architecture
  - Governance

--- 
![Clouds](./clouds.jpg)

 The truth is, there are many reasons to use a cloud service, and the priority of those reasons will vary from case to case. But it's important to know these reasons, and how you prioritize them, since they are the drivers of the cloud journey. By understanding which reasons that are most important to your mission, it will help your decision-making process.  

Some examples of decisions impacted by these drivers:  

- Whether to Use cloud or not?!
- Which cloud provider to choose
- Your operational model, traditional IT-operations teams, or adopting "you build it, you run it" model with a centre of excelence / cloud adoption team
- Adopt Infrastructure As Code (IaC) or just use a portal (graphical user interface)
- Choosing level of governance and security

There will always be trade-offs with different approaches to this and by being clear to what your motives are, it will be easier to focus on what you need to implement for your environment. 

Now, to some strong reasons to embark on a cloud journey.

### Low Investment 
![Money](./money.jpg)
There is a huge upfront cost when building or modernizing a traditional on-prem datacenter. Consider all the things you need to have in place, like cooling, fire protection, a strong Powergrid, servers, switches, routers, storage etc. On top of that you need to hire staff to build and maintain all those things. When you buy services in the cloud, all that has been done by the cloud provider, you only need to have staff to manage the "software defined" layers of the stack. If your company is a start-up, the low investment is reducing the financial risk in case the business doesn't go in line with plans. 

### Scalable Business model
![Scalable](./scalable.jpg)
Many companies consider the ability to scale the costs of their IT with the demand on their services a strong business advantage. A cloud has really neat ways to do this, as you can spin up and down resources based on demand, - and the cloud will give you tools to do it automatically. 

### Fast road to redundancy and disaster recovery
![Resilience](./resilience.jpg)
Getting redundancy and disaster recovery capabilities in traditional IT infrastructure used to be associated with a very costly investment and used to be available mostly for enterprise scale environments. When using the cloud these investments have lowered severely and things that used to be very uncommon, like disaster recovery cross continents, has been made available for both big and small organisations. 

I actually worked with a site to site (cross continent) disaster recovery project many years back, before cloud solutions had any wide spread.It was much more complex to get all the bits and pieces in place than most can imagine. You need datacenters in both locations of course, but you also need servers, clusters, storage and network that is setup in the same way in both locations. Then you need to consider the wide area network, latency and bandwidth, replication queues, etc. Doing the same in a public cloud is so much easier.

### Zero Trust security
Another thing that has changed is how we perceive security. Security used to have a strong network focus, where the internal network used to be considered safe. That perception is changing and now the focus has shifted to make the services themselves more secure and not to trust everything on the internal network. Identity is taking over the role of being the security boundary that was the internal network. In the cloud this mindset becomes the default behaviour, since your systems will have more exposure.

### Time to market, time to market, time to market
![Datacenter](./datacenter.jpg)
The time to market is probably the most common driver for cloud adoption. Organisations want their software to hit the market as early as possible, and then iterate on new features and release them as quickly as possible, and keep doing that over and over. The software development process has traditionally been a bit slow and the software has to pass many gates before being deployed to production. Usually, a piece of code has to undergo unit-tests, integration tests, acceptance tests and approvals, if any of these gates have issues the software developer has to re-iterate the whole process again. If the process is slow, the developer loses time, flow and focus. The tests are not suitable to do in the production environment, therefore identical environments are needed to carry out the tests. 

With continuous integration and continuous deployment tools this process can be automated and get much speedier. However, to reach this level of automation, the cloud has a big role to play. With Infrastructure as Code a new environment can be deployed within minutes and be removed just as fast. A template of the environment can be re-used to deploy a new environment for each gate in the process and some of these steps can even run in parallel on identical environments. When it's ready to be released, the same template can be re-used to build a new production environment, identical to the environments where the tests ran. 

**Now, some will say that you can do this in your on-prem environment** 

Yes... and no...

In traditional IT, it can take weeks or months to order a new server, rack it, connect it, install the operating system, configure everything and get it ready for service. From there on the server is treated like a pet, regular maintenance and efforts are put into keeping the server configuration from drifting as the machine is being used. Keeping the production and test environments in sync is a very difficult task, especially as changes are first applied on the test server before being shipped to the production server.
Basically, the most reliable way to make the tests reliable is to rebuild the test server using scripts or configuration management tools to make it a clean environment after the tests. All this is of course time-consuming, slow and costly.

All this has changed with the wide adoption of automation and orchestration tools, but most organisations still have a long way to travel. With infrastructure defined as code and configuration also being defined as code, the process to rebuild servers is faster and more reliable, allowing it to be done more frequently and without effort. In the cloud platforms this is supported out of the box, in an On-prem environment there is significant work to get this level of automation in the environment.

The core of the datacenter such as networks, storage and compute have to be restructured and made programmatically manageable through API's (commonly REST-API's). Basically, the infrastructure components have to be seen as data or objects that can be manipulated. All these components have to be software defined, flexible and well organised to make it easy to consume. 

Typically, an On-prem datacenter has a lot of technical debt that creates complex dependencies that will take much time and effort to sort-out, in my opinion it's too much work to transform existing infrastructure to fit this model. Building a new infrastructure on the side might be a viable option if you really really need to host in your own datacenter. 

## Next...
Thanks for reading this blog post, I hope you enjoyed it!
The [next](../setupazpowershell) couple of blogposts will be about:

- Setup an environment to work in **Azure with Powershell and VSCode and Git**
- **Authoring Custom Azure Roles**
- **Authoring Custom Azure Policies**
- **Azure Blueprints**

**Stay tuned for the next blogpost..**

/TheAutomationDude



