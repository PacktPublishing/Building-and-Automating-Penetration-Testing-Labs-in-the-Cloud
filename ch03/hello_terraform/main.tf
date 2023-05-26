resource "null_resource" "hello" {
  provisioner "local-exec" {
    command = "touch hello.txt"
  }
}
