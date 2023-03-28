output "jenkins-installation-user-data" {
    value = data.template_cloudinit_config.cloudinit-example.rendered
}