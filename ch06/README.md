# Building and Automating Penetration Testing Labs in the Cloud

<a href="https://www.packtpub.com/product/building-and-automating-penetration-testing-labs-in-the-cloud/9781837632398"><img src="https://content.packt.com/B19755/cover_image_small.jpg" alt="Book Name" height="120px" align="left" style="margin: 0px 15px; border-color: white; border-style: solid; border-width: 1px;"></a>

**Chapter 6: Setting Up Isolated Penetration Testing Lab Environments on AWS** <br />
This chapter focuses on how to build and automate the preparation of an isolated penetration testing lab environment on AWS. In this chapter, we will prepare a lab setup where we can practice pivoting techniques that can be used to access internal systems and networks using the initially compromised machine.

<br />
<br />
<br />

## Links and Files

- [https://github.com/PacktPublishing/Building-and-Automating-Penetration-Testing-Labs-in-the-Cloud/raw/main/ch06/pentest_lab.zip](https://github.com/PacktPublishing/Building-and-Automating-Penetration-Testing-Labs-in-the-Cloud/raw/main/ch06/pentest_lab.zip)

<br />

## Versions of the tools, services, and frameworks used 

- **Terraform** - `v1.3.9`
- **AWS CLI** - `2.13.14`
- **Kali Linux** - `Kali GNU/Linux Rolling | 2023.1`
- **MSF** - `6.3.31-dev`
- **Nmap** - `7.94`

<br />


## Troubleshooting tips specific to the chapter

### No space left on device error

If you encounter a **no space left on device** error while running Terraform, feel free to run the following command to see which directory inside your CloudShell environment is taking up a bit of space:

```
du -h --max-depth=1 ~
```

Once you have identified the directory, feel free to perform the necessary cleanup steps before proceeding to the next set of steps in this chapter. Make sure that you have a backup of the files and directories you are planning to delete before the actual deletion steps.

Deleting the `vulnerable_s3_lab` resources (and directory) from *Chapter 3* is easy. After running `terraform destroy -auto-approve`, you can use the `rm -rf ~/vulnerable_s3_lab` command to delete the directory along with all the files inside it.

Deleting the `backend` resources (and directory) will require a few additional steps to complete. Feel free to follow the steps discussed in the [Additional cleanup steps section for CH03](../ch03/README.md#additional-cleanup-steps).

<br />

### terraform: command not found

If Terraform is not yet installed in your AWS CloudShell environment (in case you skipped *Chapter 3*), quickly work on the step-by-step hands-on guide provided in the *Setting up Terraform in AWS CloudShell* section of *Chapter 3*

<br />

### Other troubleshooting tips

You can find other troubleshooting tips in the [TROUBLESHOOTING.md](../TROUBLESHOOTING.md) file.