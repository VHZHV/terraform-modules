variable "project_id" {
  type        = string
  description = "Project id tier will be setup."
}

variable "send_email" {
  type = object({
    resetPasswordTemplate = object({
      senderLocalPart   = string
      senderDisplayName = string
      subject           = string
      body              = string
    })
    callbackUri = string
  })
}
