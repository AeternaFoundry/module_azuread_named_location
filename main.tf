resource "azuread_named_location" "named_locations" {
  for_each = var.named_locations

  display_name = each.value.display_name

  dynamic "country" {
    for_each = each.value.country != null ? [each.value.country] : []
    content {
      countries_and_regions                 = country.value.countries_and_regions
      country_lookup_method                 = country.value.country_lookup_method
      include_unknown_countries_and_regions = country.value.include_unknown_countries_and_regions
    }
  }

  dynamic "ip" {
    for_each = each.value.ip != null ? [each.value.ip] : []
    content {
      ip_ranges = ip.value.ip_ranges
      trusted   = ip.value.trusted
    }
  }
}

