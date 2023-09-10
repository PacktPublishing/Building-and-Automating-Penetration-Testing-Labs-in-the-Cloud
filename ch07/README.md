# Building and Automating Penetration Testing Labs in the Cloud

<a href="https://www.packtpub.com/product/building-and-automating-penetration-testing-labs-in-the-cloud/9781837632398"><img src="https://content.packt.com/B19755/cover_image_small.jpg" alt="Book Name" height="120px" align="left" style="margin: 0px 15px; border-color: white; border-style: solid; border-width: 1px;"></a>

**Chapter 7: Designing and Building an IAM Privilege Escalation Lab** <br />
This chapter demonstrates how to set up a vulnerable lab environment for IAM privilege escalation on AWS. In this chapter, we also have our first look into how we can use generative AI solutions to generate code for use in penetration testing simulations.

<br />
<br />
<br />

## Links and Files

- [https://chat.openai.com/share/169f0851-c86f-43d4-aea1-4a560008f713](https://chat.openai.com/share/169f0851-c86f-43d4-aea1-4a560008f713)
- [https://chat.openai.com/share/0856c3a4-2673-4d24-869d-47b4d128d099](https://chat.openai.com/share/0856c3a4-2673-4d24-869d-47b4d128d099)
- [https://chat.openai.com/share/9913ac57-2b1e-4bce-adda-04f3521c64fe](https://chat.openai.com/share/9913ac57-2b1e-4bce-adda-04f3521c64fe)
- [https://github.com/PacktPublishing/Building-and-Automating-Penetration-Testing-Labs-in-the-Cloud/raw/main/ch07/solution/Lab%20Solution.ipynb](https://github.com/PacktPublishing/Building-and-Automating-Penetration-Testing-Labs-in-the-Cloud/raw/main/ch07/solution/Lab%20Solution.ipynb)
- [https://www.youtube.com/watch?v=ZfYDl4kaVCo](https://www.youtube.com/watch?v=ZfYDl4kaVCo)

## Versions of the tools, services, and frameworks used 

- **Terraform** - `v1.5.5`
- **AWS CLI** - `2.13.14`

<br />

## Troubleshooting tips specific to the chapter

### AWS Cloud9

In some cases, the Cloud9 instance fails to launch due to configuration issues in the VPC network settings. If you see an error similar to **Unable to access your environment... failed to create...**, you may need to use a different availability zone and/or use the default VPC when launching the Cloud9 instance. Alternatively, you may create a new VPC with public subnet(s) only to get things working quickly. You may use the VPC wizard and choose the VPC with a **Single Public Subnet** option. Once this new VPC has been created, use it along with the public subnet when configuring and creating a new Cloud9 instance. If none of this works, use a different region with an existing default VPC and try different subnets.

You should find a similar note inside an **Important note** block in the chapter.

<br />

### Other troubleshooting tips

You can find other troubleshooting tips in the [TROUBLESHOOTING.md](../TROUBLESHOOTING.md) file.