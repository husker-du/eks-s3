variable "versioning_enabled" {
  description = "Enable bucket versioning"
  type        = bool
  default     = false
}

variable "acl" {
  description = "Enable bucket versioning"
  type        = string
  default     = "private"
}