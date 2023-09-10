# Building and Automating Penetration Testing Labs in the Cloud

<a href="https://www.packtpub.com/product/building-and-automating-penetration-testing-labs-in-the-cloud/9781837632398"><img src="https://content.packt.com/B19755/cover_image_small.jpg" alt="Book Name" height="120px" align="left" style="margin: 0px 15px; border-color: white; border-style: solid; border-width: 1px;"></a>

**Chapter 4: Setting Up Isolated Penetration Testing Lab Environments on Azure** <br />
This chapter shows you how to isolate and protect vulnerable lab resources from unauthorized external attacks using a properly configured network environment. Inside this secure network environment, we will set up a target VM instance that hosts an intentionally vulnerable web application called the OWASP Juice Shop. In addition to this, we will launch an attacker VM instance and configure it with browser-based access to its desktop environment.

<br />

## Links and Files

- [target_boot_script.tpl](https://raw.githubusercontent.com/PacktPublishing/Building-Penetration-Testing-Labs-in-the-Cloud/main/ch04/pentest_lab/target_vm/target_boot_script.tpl)
- [wait_for_boot.tpl](https://raw.githubusercontent.com/PacktPublishing/Building-Penetration-Testing-Labs-in-the-Cloud/main/ch04/pentest_lab/target_vm/wait_for_boot.tpl)
- [Kali Linux Generic Cloud Image | kl_image.tar.xz](https://kali.download/cloud-images/kali-2023.1/kali-linux-2023.1-cloud-genericcloud-amd64.tar.xz)
- [https://kali.download/cloud-images/kali-2023.1/](https://kali.download/cloud-images/kali-2023.1/)

<br />

## Versions of the tools, services, and frameworks used 

- **Terraform** - `v1.5.5`
- **gsutil** - `5.25`
- **Kali Linux** - `Kali GNU/Linux Rolling | 2023.3`
- **Xvnc TigerVNC** - `1.12.0`
- **Nmap** - `7.94`
- **Docker** - `24.0.6`

<br />

## Troubleshooting tips specific to the chapter

### Kali Linux Generic Cloud Image

In case you are unable to copy the link address to download the **Kali Linux Generic Cloud Image**, you may find the Generic Cloud Image files here: https://kali.download/cloud-images/kali-2023.1/

<br />

### Other troubleshooting tips

You can find other troubleshooting tips in the [TROUBLESHOOTING.md](../TROUBLESHOOTING.md) file.