# Building and Automating Penetration Testing Labs in the Cloud

<a href="https://www.packtpub.com/product/building-and-automating-penetration-testing-labs-in-the-cloud/9781837632398"><img src="https://content.packt.com/B19755/cover_image_small.jpg" alt="Book Name" height="120px" align="left" style="margin: 0px 15px; border-color: white; border-style: solid; border-width: 1px;"></a>

**Chapter 5: Setting Up Isolated Penetration Testing Lab Environments on Azure** <br />
This chapter presents how to set up and automate an isolated penetration testing lab environment on Azure. In this chapter, we will build a lab where we can practice container breakout techniques to gain unauthorized access to the host system. In addition to this, we will look at how managed identities in Azure can be abused to gain unauthorized access to other cloud resources.

<br />
<br />
<br />

## Links and Files

- [https://ipinfo.io/ip](https://ipinfo.io/ip)
- [https://ifconfig.io/](https://ifconfig.io/)
- [https://bit.ly/create-ssh-user](https://gist.githubusercontent.com/joshualat/bec319f607001e1ffd69d41d031a5526/raw/030e7efc13bddfb64fb50935fe0487054589dcdc/create_user.sh)
- [https://bit.ly/kali-desktop-setup](https://gist.githubusercontent.com/joshualat/e01be82543c238d7f0a13f4c33f22802/raw/8b6af622f340cdce14f13260a4ca16678f1dbb50/kali_setup.sh)
- [https://bit.ly/setup-cron](https://gist.githubusercontent.com/joshualat/e01be82543c238d7f0a13f4c33f22802/raw/8b6af622f340cdce14f13260a4ca16678f1dbb50/setup_cron_job.sh)

You can also find a copy of these files in this repository (inside the `ch05` directory).

<br />

## Versions of the tools, services, and frameworks used 

- **Terraform** - `v1.3.2`
- **Azure CLI** - `2.52.0`
- **Kali Linux** - `Kali GNU/Linux Rolling | 2023.3`
- **Xvnc TigerVNC** - `1.12.0`
- **Nmap** - `7.94`
- **MSF** - `6.3.31-dev`

<br />

## Troubleshooting tips specific to the chapter

### Azure Cloud Shell

When you encounter issues using **Cloud Shell**, feel free to restart it using the **Restart Cloud Shell** button.

### Azure Key Vault

In the `target_vm/main.tf file`, make sure you update the Key Vault name value from `rg-01-key-vault` to any unused vault name as you’ll encounter the following error (since vault names are globally unique) once you run the terraform apply command in a later step: **VaultAlreadyExists — The vault name rg-01-key-vault is already in use. Vault names are globally unique so it is possible that the name is already taken**. Feel free to add random characters to the Key Vault name value to help ensure that your vault name is globally unique. A good example would be `rg-01-key-vault-a1b2c3d4`. Of course, try something else as other readers of this book may use the same vault name! Finally, we have to update the key vault name specified in the `target_vm/boot-script.sh` file as well. You should find the following line at the end of the script: 

```
az keyvault secret set --vault-name rg-01-key-vault --name "flag2" --value "FLAG # 2!"
```

You should find a similar note inside an **Important note** block in the chapter.

<br />

### Other troubleshooting tips

You can find other troubleshooting tips in the [TROUBLESHOOTING.md](../TROUBLESHOOTING.md) file.