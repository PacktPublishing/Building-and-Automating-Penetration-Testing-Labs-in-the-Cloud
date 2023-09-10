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
- **AWS CLI** - `2.13.12`

<br />

## Code Snippets

#### Amazon QLDB — PartiQL editor

```
INSERT INTO books `{"ID":"ABCD", "Title":"Machine Learning with Amazon SageMaker Cookbook", "Notes":"Machine Learning"}`;

INSERT INTO books `{"ID":"EFGH", "Title":"Machine Learning Engineering on AWS", "Notes":"Machine Learning Engineering"}`;

INSERT INTO books `{"ID":"IJKL", "Title":"Building and Automating Penetration Testing Labs in the Cloud", "Notes":"Security"}`;

SELECT * FROM books;


UPDATE books AS b SET b.Flag='Flag # 1!' WHERE b.ID='IJKL';

SELECT * FROM books;


DELETE FROM books;

SELECT * FROM books;
```

#### lambda-role trust policy

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "sagemaker.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```

#### Retrieve credentials from Instance Metadata Service Version 2 (IMDSv2)

```
TOKEN=$(curl -X PUT -H "X-aws-ec2-metadata-token-ttl-seconds:300" http://169.254.169.254/latest/api/token)

curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/identity-credentials/ec2/security-credentials/ec2-instance
```

## Troubleshooting tips specific to the chapter

### AWS Cloud9

In some cases, the Cloud9 instance fails to launch due to configuration issues in the VPC network settings. If you see an error similar to **Unable to access your environment... failed to create...**, you may need to use a different availability zone and/or use the default VPC when launching the Cloud9 instance. Alternatively, you may create a new VPC with public subnet(s) only to get things working quickly. You may use the VPC wizard and choose the VPC with a **Single Public Subnet** option. Once this new VPC has been created, use it along with the public subnet when configuring and creating a new Cloud9 instance. If none of this works, use a different region with an existing default VPC and try different subnets.

You should find a similar note inside an **Important note** block in the chapter.

<br />

### Other troubleshooting tips

You can find other troubleshooting tips in the [TROUBLESHOOTING.md](../TROUBLESHOOTING.md) file.