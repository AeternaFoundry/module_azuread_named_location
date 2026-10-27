variable "named_locations" {
  description = <<EOT
Map of named_locations, attributes below
Required:
    - display_name
Optional:
    - country (block):
        - countries_and_regions (required)
        - country_lookup_method (optional)
        - include_unknown_countries_and_regions (optional)
    - ip (block):
        - ip_ranges (required)
        - trusted (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - read (optional)
        - update (optional)
EOT

  type = map(object({
    display_name = string
    country = optional(object({
      countries_and_regions                 = list(string)
      country_lookup_method                 = optional(string)
      include_unknown_countries_and_regions = optional(bool)
    }))
    ip = optional(object({
      ip_ranges = list(string)
      trusted   = optional(bool)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.named_locations : (
        length(v.display_name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.named_locations : (
        v.country == null || (alltrue([for x in v.country.countries_and_regions : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.named_locations : (
        v.country == null || (v.country.country_lookup_method == null || (contains(["authenticatorAppGps", "clientIpAddress"], v.country.country_lookup_method)))
      )
    ])
    error_message = "must be one of: \"authenticatorAppGps\", \"clientIpAddress\""
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

