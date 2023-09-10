# Building and Automating Penetration Testing Labs in the Cloud

<a href="https://www.packtpub.com/product/building-and-automating-penetration-testing-labs-in-the-cloud/9781837632398"><img src="https://content.packt.com/B19755/cover_image_small.jpg" alt="Book Name" height="120px" align="left" style="margin: 0px 15px; border-color: white; border-style: solid; border-width: 1px;"></a>

**Chapter 3: Succeeding with Infrastructure-as-Code Tools and Strategies** <br />
This chapter details how you can use IaC solutions to build your penetration testing lab environments automatically.

<br />
<br />
<br />
<br />
<br />

## Links and Files

- [https://github.com/joshualat/sample-web-repo/raw/main/sample_website.zip](https://github.com/joshualat/sample-web-repo/raw/main/sample_website.zip)
- [https://github.com/PacktPublishing/Building-Penetration-Testing-Labs-in-the-Cloud/raw/main/ch03/sample_website.zip](https://github.com/PacktPublishing/Building-Penetration-Testing-Labs-in-the-Cloud/raw/main/ch03/sample_website.zip)
- [https://www.youtube.com/watch?v=Yl7NFenTgIo](https://www.youtube.com/watch?v=Yl7NFenTgIo)

<br />

## Versions of the tools, services, and frameworks used 

- **Terraform** - `v1.3.9`
- **AWS CLI** - `2.13.14`

<br />

## Troubleshooting tips specific to the chapter

You can find troubleshooting tips in the [TROUBLESHOOTING.md](../TROUBLESHOOTING.md) file.

<br />

## Additional cleanup steps

#### Deleting the S3 bucket used for the Terraform backend

1.  In the **AWS CloudShell** terminal, use Vim to open the `backend/main.tf` file and update `prevent_destroy` from `true` to `false`:

```
resource "aws_s3_bucket" "remote_state" {
  bucket = "<INSERT S3 BACKEND BUCKET NAME>"
  lifecycle {
    prevent_destroy = false
  }
}
```

2. In the **AWS CloudShell** terminal, run `terraform apply -auto-approve`

3. Using the AWS Management Console, locate the S3 bucket for deletion

4. Empty the S3 bucket using the **Empty** button

5. Delete the S3 bucket using the **Delete** button

6. In the **AWS CloudShell** terminal, run `terraform destroy -auto-approve`

7. You may delete the `backend` directory using the `rm -rf` command.