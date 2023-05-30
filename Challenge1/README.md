## Challenge 1

Create a 3-tier environment is a common setup. Use a tool of your choosing/familiarity create these 
resources on a cloud environment (Azure).


**What is three-tier architecture?**

Three-tier architecture is a well-established software application architecture that organizes applications into three logical and physical computing tiers: the presentation tier, or user interface; the application tier, where data is processed; and the data tier, where the data associated with the application is stored and managed.

IAC: **Terraform** (open-source infrastructure as code software tool created by HashiCorp)



![image](https://github.com/preethabarma/Preetha_KPMG_Challenge/assets/77629130/6840a98f-6869-468d-be31-68827141fd34)

**Specifications:**

+ Terraform version:  v1.4.6
+ provider registry.terraform.io/hashicorp/azurerm v3.58.0
+ provider registry.terraform.io/hashicorp/random v3.5.1



**Deployment Steps:**

Step 1: **terraform init**

used to initialize a working directory containing Terraform configuration files

Step 3: **terraform validate**

validates the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc

Step 2: **terraform plan**

used to create an execution plan

Step 4: **terraform apply**

used to apply the changes required to reach the desired state of the configuration
