output "strings" {
  description = "Map of all generated random strings"
  value       = { for k, v in random_string.random : k => v.result }
}
