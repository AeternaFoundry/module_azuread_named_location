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
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

