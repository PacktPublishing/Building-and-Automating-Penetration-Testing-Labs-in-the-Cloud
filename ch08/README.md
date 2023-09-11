# Building and Automating Penetration Testing Labs in the Cloud

<a href="https://www.packtpub.com/product/building-and-automating-penetration-testing-labs-in-the-cloud/9781837632398"><img src="https://content.packt.com/B19755/cover_image_small.jpg" alt="Book Name" height="120px" align="left" style="margin: 0px 15px; border-color: white; border-style: solid; border-width: 1px;"></a>

**Chapter 8: Designing and Building a Vulnerable Active Directory Lab** <br />
This chapter focuses on how to set up a vulnerable Active Directory lab on Azure. Here, we’ll also learn how to use various tools such as Kerbrute, Impacket, and John the Ripper to validate and assess whether the penetration testing lab environment has been set up and (mis)configured correctly.

<br />
<br />
<br />

## Links and Files

- [https://github.com/PacktPublishing/Building-and-Automating-Penetration-Testing-Labs-in-the-Cloud/raw/main/ch08/ad_lab_environment.zip](https://github.com/PacktPublishing/Building-and-Automating-Penetration-Testing-Labs-in-the-Cloud/raw/main/ch08/ad_lab_environment.zip)

<br />

## Versions of the tools, services, and frameworks used 

- **Terraform** - `v1.3.2`
- **go** - `1.21.1`
- **Kali Linux** - `Kali GNU/Linux Rolling | 2023.3`
- **Nmap** - `7.94`
- **Kerbrute** - `dev (9cfb81e) - 09/11/23`

<br />

## Troubleshooting tips specific to the chapter

### Azure Cloud Shell

When you encounter issues using **Cloud Shell**, feel free to restart it using the **Restart Cloud Shell** button.

<br />

### Error: unable to get ADAL authorization token for resource manager API

Simpy retry running the Terraform command (for example, `terraform apply -auto-approve`) in case you encounter this intermittent error.

<br />

### Other troubleshooting tips

You can find other troubleshooting tips in the [TROUBLESHOOTING.md](../TROUBLESHOOTING.md) file.