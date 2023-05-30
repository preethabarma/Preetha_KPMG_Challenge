## Challenge 2

We need to write code that will query the meta data of an instance within AWS or Azure or GCP
and provide a json formatted output.
The choice of language and implementation is up to you.


**Solution**

The Azure Instance Metadata Service (IMDS) provides information about currently running virtual machine instances. You can use it to manage and configure your virtual machines. This information includes the SKU, storage, network configurations, and upcoming maintenance events.

IMDS is a REST API that's available at a well-known, non-routable IP address (169.254.169.254). You can only access it from within the VM.



**Step 1:** Create Virtual Machine in Azure Subscription

**Step 2:** Connect to the Virtual Machine created.

**Step 3:** Run the below PowerShell script on the virtual machine to get the required metadata.



**Note**

IMDS (Azure Instance Metadata Service) endpoint:
http://169.254.169.254/metadata/instance?api-version=2021-02-01

**Parameters**

api-version	   2021-02-01

format	json
