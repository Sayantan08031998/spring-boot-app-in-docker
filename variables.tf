variable "region" {
  type   = "string"
  region = "ap-south-1"
}

variable "docker_image_tag" {
  type        = string
  description = "This is the tag which will be used for the image that you created"
  default     = "latest"
}
