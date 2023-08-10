#################################################
# OUTPUTS                                       #
#################################################
## OpenAI Service Account Details
output "openai_endpoint" {
  description = "The endpoint used to connect to the Cognitive Service Account."
  value       = module.openai.openai_endpoint
}

output "openai_primary_key" {
  description = "The primary access key for the Cognitive Service Account."
  sensitive   = true
  value       = module.openai.openai_primary_key
}

output "openai_secondary_key" {
  description = "The secondary access key for the Cognitive Service Account."
  sensitive   = true
  value       = module.openai.openai_secondary_key
}

output "openai_subdomain" {
  description = "The subdomain used to connect to the Cognitive Service Account."
  value       = module.openai.openai_subdomain
}

output "openai_account_name" {
  description = "The name of the Cognitive Service Account."
  value       = module.openai.openai_account_name
}

## key vault
output "key_vault_id" {
  description = "The ID of the Key Vault used to store OpenAI account and model details."
  value       = module.openai.key_vault_id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault used to store OpenAI account and model details.."
  value       = module.openai.key_vault_uri
}

## Container App Enviornment
output "container_app_enviornment_id" {
  description = "The ID of the container app enviornment."
  value       = azurerm_container_app_environment.gpt.id
}

## Container App
output "container_app_id" {
  description = "The ID of the container app."
  value       = azurerm_container_app.gpt.id
}

output "latest_revision_fqdn" {
  description = "The FQDN of the Latest Revision of the Container App."
  value       = azurerm_container_app.gpt.latest_revision_fqdn
}
