provider "packet" {
  auth_token = "${var.auth_token}"
}

data "template_file" "cloud_init" {
  template = "${file("user-data.config")}"
}

resource "packet_device" "server" {
  count            = "${var.server_count}"
  hostname         = "${format("%s-%01d", var.hostname, count.index)}"
  plan             = "${var.server_size}"
  facilities       = ["${var.facility}"]
  operating_system = "${var.operating_system}"
  billing_cycle    = "${var.billing_cycle}"
  project_id       = "${var.project_id}"
  user_data        = "${data.template_file.cloud_init.rendered}"
}
