
data "template_file" "shell-script" {
    template = "${file("./scripts/files/jenkins-installation.sh")}"
}


data "template_cloudinit_config" "cloudinit-example" {
    gzip = false
    base64_encode = false

    part {
        filename = "jenkins-installation.sh"
        content_type = "text/x-shellscript"
        content = "${data.template_file.shell-script.rendered}"
    }
}