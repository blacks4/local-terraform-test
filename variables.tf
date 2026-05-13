variable "how_many_secrets" {
  type    = number
  default = 7
}

variable "string_length" {
  type = string
}

variable "include_special" {
  type = bool
}

variable "override_special" {
  type = string
}

variable "random_string_configs" {
  type = map(object({
    length           = number
    include_special  = bool
    override_special = string
  }))
  default = {}
}
