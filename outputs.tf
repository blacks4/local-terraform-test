output "strings" {
  description = "Map of all generated random strings"
  value       = { for k, v in random_string.random : k => v.result }
}

output "strings_from_map" {
  description = "Map of generated random strings from random_string_configs"
  value       = { for k, v in random_string.random_from_map : k => v.result }
}
