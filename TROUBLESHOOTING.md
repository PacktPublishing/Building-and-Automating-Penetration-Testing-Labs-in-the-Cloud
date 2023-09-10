### TROUBLESHOOTING TIPS

1. When you encounter issues while running `terraform apply -auto-approve`, running the command again may resolve the intermittent issues from the previous run of the command. In some cases, you may need to run the command a few times especially if some resources take a bit of time to create. 

2. When you encounter issues while running `terraform apply -auto-approve`, another option would be to delete the resources using `terraform destroy -auto-approve`. Once the resources have been deleted, we can then create the resources again using `terraform apply -auto-approve` to see if the issue(s) encountered have been resolved by recreating the resources.

3. If you are having issues deleting certain resources with `terraform destroy -auto-approve`, you may delete those resources manually and then run `terraform destroy -auto-approve` again. 

4. In some cases, you may simply need to wait for a few extra minutes for some changes to take effect.

5. It is essential that you compare your current code with the code stored in this book's GitHub repository. You may use a diff checker to make sure that the codes match.

6. Take note that it is possible that you might have missed a step, typed the wrong command, or missed a few characters while typing.

7. It is possible that the issue you've encountered is an intermittent issue from the cloud platform end. You may refresh the browser to see if that solves the problem. You may also try signing out and then signing in as well to help you troubleshoot and resolve issues.

8. While this is not recommended, another option would be to delete the resources manually and then delete the generated Terraform files (`.terraform` folder, `.terraform.lock.hcl` file, `terraform state` file) as well. After that, we can start creating the resources again by running `terraform init`, `terraform plan`, and then `terraform apply -auto-approve`.

9. In the worst case, you may simply perform the exercise again to start with a clean slate.

10. Make sure that you are using the correct version of the tools. In some cases, you might need to use a lower version of certain tools in case you are having issues with the latest version available.

11. You can also reach out to Packt and the Author to help you resolve specific blockers as well.